class PromotionResponse {
  final bool success;
  final PromoData data;

  PromotionResponse({
    required this.success,
    required this.data,
  });

  // Factory method to create an instance from JSON
  factory PromotionResponse.fromJson(Map<String, dynamic> json) {
    return PromotionResponse(
      success: json['success'],
      data: PromoData.fromJson(json['data']),
    );
  }
}

class PromoData {
  final int id;
  final String promotionId;
  final int shopId;
  final String name;
  final String description;
  final int status;
  final String start;
  final String end;
  final String banner;
  final List<PromoProduct> items;

  PromoData({
    required this.id,
    required this.promotionId,
    required this.shopId,
    required this.name,
    required this.description,
    required this.status,
    required this.start,
    required this.end,
    required this.banner,
    required this.items,
  });

  factory PromoData.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<PromoProduct> promoItems = itemsList.map((i) => PromoProduct.fromJson(i)).toList();

    return PromoData(
      id: json['id'],
      promotionId: json['promotion_id'],
      shopId: json['shop_id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      start: json['start'],
      end: json['end'],
      banner: json['banner'],
      items: promoItems,
    );
  }
}

class PromoProduct {
  final int id;
  final int productId;
  final String discountType;
  final String discountValue;
  final double promotionPrice; // Changed from String to double
  final Product product;
  final int quantityLimit;

  PromoProduct({
    required this.id,
    required this.productId,
    required this.discountType,
    required this.discountValue,
    required this.promotionPrice,
    required this.product,
    required this.quantityLimit,
  });

  factory PromoProduct.fromJson(Map<String, dynamic> json) {
    return PromoProduct(
      id: json['id'],
      productId: json['product_id'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      promotionPrice: double.parse(json['promotion_price'] ?? '0.0'), // Parsing to double
      product: Product.fromJson(json['product']),
      quantityLimit: json['quantity_limit'],
    );
  }
}


class Product {
  final int id;
  final String name;
  final String image;
  final double price;

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
      price: double.parse(json['price'] ?? '0.0'),
    );
  }
}
