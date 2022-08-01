class Discount {
  String? discount;
  String? description;

  Discount getDummy() {
    Discount discount = Discount();
    discount.discount = 'Discount Coupons';
    discount.description = 'Offered up to 30% off for retweet with demand';
    return discount;
  }
}
