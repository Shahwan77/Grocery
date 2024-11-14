class Deal {
  final int id;
  final int shopId;
  final int productId;
  final String price;
  final bool popular;
  final int discount;
  final String discountType;
  final String discountValue;
  final String promotionPrice;
  final Product product;

  Deal({
    required this.id,
    required this.shopId,
    required this.productId,
    required this.price,
    required this.popular,
    required this.discount,
    required this.discountType,
    required this.discountValue,
    required this.promotionPrice,
    required this.product,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      shopId: json['shop_id'],
      productId: json['product_id'],
      price: json['price'],
      popular: json['popular'] == 1,
      discount: json['discount'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      promotionPrice: json['promotion_price'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
    );
  }
}
