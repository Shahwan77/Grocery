class Deal {
  final int id;
  final int shopId;
  final int? productId; // Made nullable
  final String price;
  final bool popular;
  final int? discount; // Made nullable
  final String? discountType; // Made nullable
  final String? discountValue; // Made nullable
  final String? promotionPrice; // Made nullable
  final Product? product; // Made nullable

  Deal({
    required this.id,
    required this.shopId,
    this.productId,
    required this.price,
    required this.popular,
    this.discount,
    this.discountType,
    this.discountValue,
    this.promotionPrice,
    this.product,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'] ?? 0, // Default to 0 if null
      shopId: json['shop_id'] ?? 0, // Default to 0 if null
      productId: json['product_id'], // Nullable
      price: json['price'] ?? '', // Default to an empty string if null
      popular: json['popular'] == 1,
      discount: json['discount'], // Nullable
      discountType: json['discount_type'], // Nullable
      discountValue: json['discount_value'], // Nullable
      promotionPrice: json['promotion_price'], // Nullable
      product: json['product'] != null ? Product.fromJson(json['product']) : null, // Handle null
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
      id: json['id'] ?? 0, // Default to 0 if null
      name: json['name'] ?? '', // Default to empty string if null
      image: json['image'] ?? '', // Default to empty string if null
      price: json['price'] ?? '', // Default to empty string if null
    );
  }
}
