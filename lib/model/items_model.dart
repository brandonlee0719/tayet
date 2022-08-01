class Items {
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? title;
  String? content;
  String? auctionTitle;
  String? retail_price;
  String? mininum_price;
  String? id;
  List<String>? productImages;
  String? name, image, day;
  int? price, qty;
  DateTime? start_Date;
  DateTime? close_Date;
  double? bidding_rate;
  int? totalBids = 0;
  List<String>? imageUrl;
  int? participantCount = 0;

  Items(
      {this.createdDate,
      this.modifiedDate,
      this.title,
      this.content,
      this.auctionTitle,
      this.retail_price,
      this.mininum_price,
      this.productImages,
      this.id,
      this.start_Date,
      this.close_Date,
      this.bidding_rate,
      this.totalBids,
      this.imageUrl,
      this.participantCount});
  factory Items.fromJson(Map<String, dynamic> json) => Items(
      id: json['id'].toString(),
      createdDate: DateTime.parse(json['date']),
      modifiedDate: DateTime.parse(json['date_gmt']),
      title: json['title']['rendered'],
      start_Date: (json['starting_date'].isEmpty)
          ? DateTime.now()
          : DateTime.parse(json['starting_date']),
      close_Date: (json['closing_date'].isEmpty)
          ? DateTime.now()
          : DateTime.parse(json['closing_date']),
      content: json['content']['rendered'],
      auctionTitle: json['auction_title'],
      retail_price: json['retail_price'],
      mininum_price: json['minimum_price'],
      bidding_rate: double.parse(json['bidding_rate']),
      // imageUrl: json['product_gallery']['guid'],
      imageUrl: List<String>.from(json['galleryList']),
      participantCount: json['totalBidders']);
}
