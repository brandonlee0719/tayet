import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../apilink.dart';
import '../features/payment/controllers/payment_controller.dart';
import '../model/coins_model.dart';
import '../repository.dart/user_repository.dart';

class WalletRepository extends GetxController {
  final walletRef = FirebaseFirestore.instance.collection("wallets");
  final Rx<double> _coinBalance = 100.0.obs;
  double get coinBalance => _coinBalance.value;
  final _userController = Get.find<UserRepository>();
  final Rx<List<Coins>> _coinList = Rx([]);
  List<Coins> get coinList => _coinList.value;
  static const String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _userController.status.listen((p0) {
      if (p0 == Status.authenticStat) {
        getWalletBalance(_userController.userModel.id!);
        getCoin();
      }
    });
  }

  /// create get wallet balance
  Future createWallet(String userId) async {
    walletRef.doc(userId).set({
      "coinBalance": 10000.00,
    });
  }

  Future updateFundToWallet(String userId, double coinValue) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      var value = await walletRef.doc(userId).get();
      if (value.exists) {
        transaction.update(walletRef.doc(userId),
            {"coinBalance": FieldValue.increment(coinValue)});
      } else {
        if (kDebugMode) {
          print("Coins balance: $coinValue");
        }

        transaction.set(walletRef.doc(userId), {
          "coinBalance": coinValue,
        });
        // walletRef.doc(userId).set({"coinBalance": coinValue});
      }
      // TODO: updating the coin balance in the wallet NOT the API!!
      // updateCoinPack(coinValue);
    });
  }

  Future updateCoinPack(double value) async {
    print("updating coin pack ");
    try {
      String username = 'appdeamon';
      String password = 'Zop6 1HYu 2SIt Ddvp hBUX 8YPg';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var response = await http.patch(Uri.parse(ApiLink.coinPack),
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth,
          },
          body: jsonEncode({"purchase_count": value}));

      print("coin pack response ${response.body}");
    } catch (ex) {
      print("update pack error ${ex.toString()}");
    }
  }

  Future getWalletBalance(String userId) async {
    if (userId.isEmpty) {
      Get.log("user id is empty");
      return;
    }
    walletRef.doc(userId).snapshots().listen((event) {
      if (event.exists) {
        double balance = event.data()!['coinBalance'].toDouble();
        _coinBalance((balance * 1.0).floorToDouble());
      }
    });
  }

  Future addFundToWallet(String amountText) async {
    final amount = double.tryParse(amountText);

    if (amount == null) {
      return;
    }

    PaymentController.instance.startPayment(
      amount: amount,
      onSuccess: () {
        updateFundToWallet(_userController.userModel.id!, amount);
      },
    );
  }

  Future getCoin() async {
    var response = await http.get(
        Uri.parse("https://tayet3aleeh.com/wp-json/wp/v2/coinsacks?_embed"));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      final result = List.from(json).map((e) => Coins.fromJson(e)).toList();

      _coinList(result);
    }
  }
}
