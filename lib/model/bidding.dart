class Bidding {
  int? id;

  String? countyCode;
  double? amount;
  String? userId;
  String? userName;
  DateTime? createdTime;

  Bidding(
      {this.id,
      this.countyCode,
      this.amount,
      this.userId,
      this.userName,
      this.createdTime});
  factory Bidding.fromJson(Map<String, dynamic> json) => Bidding(
      id: json['id'],
      countyCode: json['countryCode'],
      userId: json['userId'],
      userName: json['userName'],
      amount: json['amount'] * 1.0,
      createdTime: DateTime.parse(json['createdTime']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "countryCode": countyCode,
        "userId": userId,
        "userName": userName,
        "amount": amount,
        "createdTime": createdTime!.toIso8601String()
      };
      
  // static List<Bidding> sampleList = [
  //   Bidding(id: 1, countyCode: "US", amount: 200, userId: "", userName: "John"),
  //   Bidding(
  //       id: 1, countyCode: "GB", amount: 150, userId: "", userName: "Stone"),
  //   Bidding(id: 1, countyCode: "NG", amount: 100, userId: "", userName: "Wale"),
  //   Bidding(
  //       id: 1, countyCode: "RU", amount: 50, userId: "", userName: "Biodun"),
  //   Bidding(id: 1, countyCode: "NG", amount: 10, userId: "", userName: "Dayo"),
  //   Bidding(id: 1, countyCode: "NG", amount: 10, userId: "", userName: "Payo"),
  //   Bidding(id: 1, countyCode: "US", amount: 200, userId: "", userName: "John"),
  //   Bidding(
  //       id: 1, countyCode: "GB", amount: 150, userId: "", userName: "Stone"),
  //   Bidding(id: 1, countyCode: "NG", amount: 100, userId: "", userName: "Wale"),
  //   Bidding(
  //       id: 1, countyCode: "RU", amount: 50, userId: "", userName: "Biodun"),
  //   Bidding(id: 1, countyCode: "NG", amount: 10, userId: "", userName: "Dayo"),
  //   Bidding(id: 1, countyCode: "NG", amount: 10, userId: "", userName: "Payo"),
  // ];
}
