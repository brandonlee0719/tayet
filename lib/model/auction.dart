import 'package:smart_auction/model/bidding.dart';

class Auction {
  String? id;
  String? itemName;
  List<Bidding>? bidder;
  int? totalBids;

  double? retail_price;
  double? mininum_price;
  DateTime? startingTime;

  DateTime? closing_time;
  double? biddingRate;
  double? currentAuctionValue;
  bool? isSold;
  List<String>? imageList;
  int? totalBidders;
  List<int>? categoryList;

  Auction(
      {this.id,
      this.itemName,
      this.bidder,
      this.totalBids,
      this.retail_price,
      this.mininum_price,
      this.startingTime,
      this.closing_time,
      this.biddingRate,
      this.currentAuctionValue,
      this.isSold,
      this.imageList,
      this.totalBidders,
      this.categoryList});

  factory Auction.fromJson(Map<String, dynamic> json) => Auction(
      id: json['id'],
      biddingRate: json['bidding_rate'] * 1.0,
      itemName: json['itemName'],
      bidder: json['bidder'] == null
          ? []
          : List.from(json['bidder']).map((e) => Bidding.fromJson(e)).toList(),
      startingTime: DateTime.parse(json['starting_date']),
      retail_price: json['retailPrice']?.toDouble(),
      mininum_price: json['minimumPrice']?.toDouble(),
      currentAuctionValue: json['currentAuctionValue'] * 1.0,
      closing_time: DateTime.parse(
        json['closing_date'],
      ),
      isSold: json['isSold'],
      imageList: json['imageList'] == null && json['imageList'] is List
          ? json['imageList']
          : List.from(json['imageList']).map((e) => e as String).toList(),
      totalBidders:
          json['bidder'] == null ? 0 : List.from(json['bidder']).length,
      categoryList: (json['categories'] != null) && json['categories'] is List
          ? List.from(json['categories']).map((e) => e as int).toList()
          : []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemName": itemName,
        "bidder": bidder == null ? [] : bidder!.map((e) => e.toJson()).toList(),
        "totalBids": totalBids,
        "starting_date": startingTime!.toIso8601String(),
        "retailPrice": retail_price,
        "minimumPrice": mininum_price,
        "closing_date": closing_time!.toIso8601String(),
        "currentAuctionValue": currentAuctionValue,
        "bidding_rate": biddingRate,
        "isSold": false,
        "imageList": imageList,
        "totalBidders": totalBidders,
        "categories": categoryList,
      };
}
