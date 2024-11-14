class Promotion {
  final int id;
  final String promotionId;
  final String name;
  final String description;
  final String status;
  final String start;
  final String end;
  final String banner;
  final List<Item> items;

  Promotion({
    required this.id,
    required this.promotionId,
    required this.name,
    required this.description,
    required this.status,
    required this.start,
    required this.end,
    required this.banner,
    required this.items,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();

    return Promotion(
      id: json['id'],
      promotionId: json['promotion_id'],
      name: json['name'],
      description: json['description'],
      status: json['status'].toString(),
      start: json['start'],
      end: json['end'],
      banner: json['banner'],
      items: itemsList,
    );
  }
}

class Item {
  final int id;
  final int productId;
  final String discountType;
  final String discountValue;
  final String promotionPrice;
  final Product product;

  Item({
    required this.id,
    required this.productId,
    required this.discountType,
    required this.discountValue,
    required this.promotionPrice,
    required this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      productId: json['product_id'],
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
