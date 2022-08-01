class UserModel {
  String? email;
  String? firstName;
  String? userName;
  String? lastName;
  String? country;
  DateTime? dob;
  DateTime? createdAt;
  String? id;
  String? imageUrl;
  int? wpId;
  double? walletCoins;

  UserModel(
      {this.email,
      this.firstName,
      this.country,
      this.dob,
      this.createdAt,
      this.id,
      this.lastName,
      this.userName,
      this.wpId,
      this.imageUrl,
      this.walletCoins});

  factory UserModel.fromJson(dynamic json) => UserModel(
      id: json['id'] ?? "",
      email: json['email'],
      country: json['country'],
      dob: json['null'] == null ? null : DateTime.parse(json['dob']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      wpId: json['wpId'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      walletCoins: json['walletCoins'] ?? 10000.00);

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "country": country,
        "dob": dob == null ? null : dob!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
        "lastName": lastName,
        "userName": userName,
        "firstName": firstName,
        "wpId": wpId,
        "imageUrl": imageUrl,
        "walletCoins": walletCoins,
      };
}
