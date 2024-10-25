class Orderlist {
  final int id;
  final int shopId;
  final String orderId;
  final int userId;
  final String type;
  final String? deliveryDate;
  final String? paymentMethod;
  final String? paymentChange;
  final int totalCount;
  final String totalAmount;
  final String status;
  final List<Item> items;

  Orderlist({
    required this.id,
    required this.shopId,
    required this.orderId,
    required this.userId,
    required this.type,
    this.deliveryDate,
    this.paymentMethod,
    this.paymentChange,
    required this.totalCount,
    required this.totalAmount,
    required this.status,
    required this.items,
  });

  factory Orderlist.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as List;
    List<Item> items = itemList.map((i) => Item.fromJson(i)).toList();

    return Orderlist(
      id: json['id'],
      shopId: json['shop_id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      type: json['type'],
      deliveryDate: json['delivery_date'],
      paymentMethod: json['payment_method'],
      paymentChange: json['payment_change'],
      totalCount: json['total_count'],
      totalAmount: json['total_amount'],
      status: json['status'],
      items: items,
    );
  }
}

class Item {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final Product product;

  Item({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String type;
  final String name;
  final String image;
  final String price;

  Product({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
    );
  }
}
