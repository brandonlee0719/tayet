import 'dart:async' show Future;
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_auction/model/auction.dart';
import 'package:smart_auction/model/bidding.dart';
import 'package:smart_auction/model/items_model.dart';
import 'package:smart_auction/model/user_model.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';
import 'package:smart_auction/repository.dart/wallet_repository.dart';

class BidItemRepository extends GetxController {
  final Rx<List<Items>> _biddingItems = Rx([]);
  List<Items> get biddingItems => _biddingItems.value;
  final Rx<List<Auction>> _auctionList = Rx([]);
  List<Auction> get auctionList => _auctionList.value;
  final Rx<List<Auction>> _closeAuctions = Rx([]);
  final _bidController = FirebaseFirestore.instance.collection("Auctions");
  List<Auction> get closedAuctionList => _auctionList.value;
  final Rx<Auction?> _currentAuction = Rx(null);
  Auction? get currentAuction => _currentAuction.value;
  Rx<Items?> currentItem = Rx(null);
  final Rx<List<Auction>> _myBids = Rx([]);
  List<Auction> get myBids => _myBids.value;

// StreamSubscription
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBiddingItem();
    getAuctions();
    currentItem.listen((p0) async {
      log("Item ID listening: ${p0!.id}", level: 2);
      _currentAuction(Auction());

      var result = await _bidController.doc(p0.id).get();

      if (result.data() != null) {
        log("it exist ");
        var newAuction = Auction.fromJson(result.data()!);
        _currentAuction(newAuction);
      } else {
        _currentAuction(Auction());
        log("it doesnt not exist");
      }
      _bidController.doc(p0.id!).snapshots().listen((event) {
        if (event.data() == null) {
          _currentAuction(Auction());
          return;
        }
        var newAuction = Auction.fromJson(event.data()!);
        _currentAuction(newAuction);
      });

      log("current item is $currentAuction.id");
    });
  }

  void setCurrentAuction(Auction auction) {
    _currentAuction(auction);
  }

  Future getBiddingItem() async {
    // TODO: Unify the WP authentication with single function
    try {
      String username = 'appdeamon';
      String password = 'Zop6 1HYu 2SIt Ddvp hBUX 8YPg';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var response = await http.get(
          Uri.parse("https://tayet3aleeh.com/wp-json/wp/v2/t3_auction?_embed"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth,
          });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // DateTime dd = DateTime.now();

        // var list = List.from(json)
        //     .map((e) => Items.fromJson(e))
        //     .where((element) => (element.close_Date!.isAfter(dd)))
        //     .toList();
        var list = List.from(json).map((e) => Items.fromJson(e)).toList();

        // FIXED: show total numbers of bidders
        Get.log("Done loading auction items");
        var totalAuctions = list.length;
        Get.log("Total Auctions Pulled: $totalAuctions");
        _biddingItems(list);
      }
    } catch (ex) {
      log("error occurred ${ex.toString()}");
    }
  }

  Future getAuctions() async {
    _bidController.snapshots().listen((event) {
      List<Auction> value = [];
      List<Auction> closeBid = [];
      for (var element in event.docs) {
        var auction = element.data();
        // FIXME: remove this line
        log("Retriving Auctions:");
        // log(const JsonEncoder().convert(auction.entries.first).toString());
        var item = Auction.fromJson(element.data());
        // item.totalBidders = item.bidder?.length;

        value.add(item);
        if (item.isSold!) closeBid.add(item);
      }

      _auctionList(value);
      _closeAuctions(closeBid);
    });
    getUserActiveBid();
  }

  Future getCloseAuction() async {}

  Auction? checkIfAuctionAvailable(String id) {
    if (auctionList.isEmpty) {
      return null;
    }
    Auction? result;
    for (var element in auctionList) {
      if (element.id == id) {
        result = element;
        var totBidders = result.bidder?.length;
        result.totalBidders = totBidders;
        log("Auction ID: $id |||| Total Bidders: $totBidders");
      }
    }

    return result;
  }

  /// Get the current user active bids
  /// ANCHOR: needs to be refactored
  Future bidAvaiableAuction(Auction result) async {
    final userRepository = Get.find<UserRepository>();
    final walletController = Get.find<WalletRepository>();
    UserModel user = userRepository.userModel;
    if (walletController.coinBalance < result.biddingRate!) {
      Get.snackbar("Error", "Insufficient Balance");
      return;
    }
    var bidderList = result.bidder;
    var totalbid = (result.currentAuctionValue! + result.biddingRate!);
    // var dateNow = DateTime.now();
    var bidder = Bidding(
        countyCode:
            user.country!.split(" ")[1].replaceAll("(", "").replaceAll(")", ""),
        amount: double.parse(totalbid.toStringAsFixed(2)),
        userName: user.userName,
        userId: user.id,
        createdTime: DateTime.now());
    bidderList!.add(bidder);
    walletController.updateFundToWallet(userRepository.userModel.id!,
        -1 * double.parse(result.biddingRate!.toStringAsFixed(2)));

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(_bidController.doc(result.id!), {
        "bidder": FieldValue.arrayUnion([bidder.toJson()]),
        "currentAuctionValue": double.parse(totalbid.toStringAsFixed(2)),
        "totalBidders": bidderList.length,
      });
    });
  }

  Future bidAuction(Items auctionItem) async {
    final userRepository = Get.find<UserRepository>();
    final walletController = Get.find<WalletRepository>();
    UserModel user = userRepository.userModel;

    Auction? auctionResult = checkIfAuctionAvailable(auctionItem.id!);
    if (kDebugMode) {
      log("bidding rate is ${auctionItem.bidding_rate}");
    }
    if (auctionResult == null) {
      if (walletController.coinBalance < auctionItem.bidding_rate!) {
        Get.snackbar("Error", "Insufficient Balance");
        return;
      }
      Get.log("Current balance: ${userRepository.userModel.walletCoins}");
      if (user.walletCoins! >= auctionItem.bidding_rate!) {
        var newBalance = user.walletCoins! - auctionItem.bidding_rate!;
        user.walletCoins = newBalance;

        walletController.updateFundToWallet(
            userRepository.userModel.id!, -1 * newBalance);
      }
      var todaysDate = DateTime.now();

      var bidLog = Bidding(
        countyCode:
            user.country!.split(" ")[1].replaceAll("(", "").replaceAll(")", ""),
        amount: double.parse(auctionItem.bidding_rate!.toStringAsFixed(2)),
        userName: user.userName,
        userId: user.id,
        createdTime: todaysDate,
      );

      auctionResult = Auction(
        id: auctionItem.id,
        itemName: auctionItem.auctionTitle,
        retail_price: double.parse(auctionItem.retail_price!),
        mininum_price: double.parse(auctionItem.mininum_price!),
        startingTime: todaysDate,
        closing_time: auctionItem.close_Date,
        biddingRate: double.parse(auctionItem.bidding_rate!.toStringAsFixed(2)),
        currentAuctionValue: auctionItem.bidding_rate,
        bidder: [bidLog],
        imageList: auctionItem.productImages,
        totalBidders: [bidLog].length,
      );

      _bidController.doc(auctionResult.id).set(auctionResult.toJson());

      // walletController.updateFundToWallet(userRepository.userModel.id!,
      //     -1.00 * double.parse(auctionItem.bidding_rate!.toStringAsFixed(2)));
    } else {
      if (walletController.coinBalance < auctionResult.biddingRate!) {
        Get.snackbar("Error", "Insufficient Balance");
        return;
      }
      var bidderList = auctionResult.bidder;
      var totalbid =
          (auctionResult.currentAuctionValue! + auctionResult.biddingRate!);
      if (kDebugMode) {
        log("bidding rate is ${auctionResult.biddingRate}  and total bid is $totalbid");
      }
      // var todaysDate = DateTime.now();
      var bidder = Bidding(
          countyCode: user.country!
              .split(" ")[1]
              .replaceAll("(", "")
              .replaceAll(")", ""),
          amount: double.parse(totalbid.toStringAsFixed(2)),
          userName: user.userName,
          userId: user.id,
          createdTime: DateTime.now());
      bidderList!.add(bidder);
      walletController.updateFundToWallet(userRepository.userModel.id!,
          -1 * double.parse(auctionItem.bidding_rate!.toStringAsFixed(2)));
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(_bidController.doc(auctionResult!.id!), {
          "imageList": auctionItem.imageUrl,
          "bidder": FieldValue.arrayUnion([bidder.toJson()]),
          "currentAuctionValue": double.parse(totalbid.toStringAsFixed(2))
        });

        // if(result!.closing_time.isNullOrBlank)
      });
    }
  }

  Future getUserActiveBid() async {
    _auctionList.listen((p0) {
      final userRepository = Get.find<UserRepository>();

      UserModel user = userRepository.userModel;
      List<Auction> myBid = [];
      if (kDebugMode) {
        log("auction for testing is ${p0.length}");
      }
      for (var element in auctionList) {
        if (element.bidder!.isNotEmpty) {
          final result = element.bidder!
              .where((element) => element.userId != user.id)
              .toList();

          if (result.isNotEmpty) {
            if (!element.isSold!) {
              myBid.add(element);
            }
          }
        }
      }

      _myBids(myBid);
      if (kDebugMode) {
        log("number of active user bids found is ${myBid.length}");
      }
    });
  }
}
