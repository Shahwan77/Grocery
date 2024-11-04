class ResponseModel {
  final bool success;
  final ReplaceOrder data;

  ResponseModel({required this.success, required this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      data: ReplaceOrder.fromJson(json['data']),
    );
  }
}

class ReplaceOrder {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final List<ReplacementItem> replaceItems;
  final Product product;

  ReplaceOrder({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.replaceItems,
    required this.product,
  });

  factory ReplaceOrder.fromJson(Map<String, dynamic> json) {
    var replaceItemsFromJson = json['replace_items'] as List;
    List<ReplacementItem> replacementItemsList =
    replaceItemsFromJson.map((i) => ReplacementItem.fromJson(i)).toList();

    return ReplaceOrder(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      replaceItems: replacementItemsList,
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String type;
  final String name;
  final int categoryId;
  final int? subcategoryId;
  final String? description;
  final String image;
  final String price;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int popular;
  final int discount;

  Product({
    required this.id,
    required this.type,
    required this.name,
    required this.categoryId,
    this.subcategoryId,
    this.description,
    required this.image,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.popular,
    required this.discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      popular: json['popular'],
      discount: json['discount'],
    );
  }
}

class ReplacementItem {
  final int id;
  final int shopId;
  final int itemId;
  final int replacementItemId;
  final int confirm;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  ReplacementItem({
    required this.id,
    required this.shopId,
    required this.itemId,
    required this.replacementItemId,
    required this.confirm,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory ReplacementItem.fromJson(Map<String, dynamic> json) {
    return ReplacementItem(
      id: json['id'],
      shopId: json['shop_id'],
      itemId: json['item_id'],
      replacementItemId: json['replacement_item_id'],
      confirm: json['confirm'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['product']),
    );
  }
}
