class Coins {
  String? name,
   image;
  double? price;
  int? id;


  Coins({this.name, this.image, this.price});


factory Coins.fromJson(Map<String,dynamic> json)=>Coins(
name: json['coinsack_name'],
image: json['sack_image']['guid'],
price:double.parse( json['sack_price'])
);

  
}

List<Coins> CoinsList = [
  Coins(name: '50 coins', image: 'assets/images/coin1.png', price: 30),
  Coins(name: '80 coins', image: 'assets/images/coin2.png', price: 50),
  Coins(name: '150 coins', image: 'assets/images/coin1.png', price: 100),
  Coins(name: '200 coins', image: 'assets/images/coin2.png', price: 250),
  Coins(name: '450 coins', image: 'assets/images/coin1.png', price: 300),
  Coins(name: '700 coins', image: 'assets/images/coin2.png', price: 450),
  Coins(name: '850 coins', image: 'assets/images/coin1.png', price: 600),
  Coins(
    name: '1000 coins',
    image: 'assets/images/coin2.png',
    price: 750,
  ),
];
