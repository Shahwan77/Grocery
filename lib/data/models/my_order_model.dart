import '../../presentation/order_details/my_orders.dart';

class Order {
  final List<Item> items;
  final String totalAmount;
  final int totalQuantity;
  final String? collectionDate;
  final String collectionTime;
  final String deliveryDate;
  final String deliveryTime;
  final String paymentMethod;
  final String? paymentChange;

  Order({
    required this.items,
    required this.totalAmount,
    required this.totalQuantity,
    this.collectionDate,
    required this.collectionTime,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.paymentMethod,
    this.paymentChange,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['data']['items'] as List;
    List<Item> itemsList;

    // Creating the item list based on the type of order
    itemsList = itemsJson.map((item) {
      if (json['data']['type'] == 'grocery') {
        return GroceryItem.fromJson(item);
      } else {
        return LaundryItem.fromJson(item);
      }
    }).toList();

    return Order(
      items: itemsList,
      totalAmount: json['data']['total_amount'],
      totalQuantity: json['data']['total_quantity'],
      collectionDate: json['data']['collection_date'],
      collectionTime: json['data']['collection_time'],
      deliveryDate: json['data']['delivery_date'],
      deliveryTime: json['data']['delivery_time'],
      paymentMethod: json['data']['payment_method'],
      paymentChange: json['data']['payment_change'],
    );
  }
}



class Item {
  final int productId;
  final String name;
  final String price;
  final String? image; // Nullable for laundry items
  final int quantity;

  Item({
    required this.productId,
    required this.name,
    required this.price,
    this.image,
    required this.quantity,
  });
}

// Grocery item class
class GroceryItem extends Item {
  GroceryItem({
    required int productId,
    required String name,
    required String price,
    String? image,
    required int quantity,
  }) : super(
    productId: productId,
    name: name,
    price: price,
    image: image,
    quantity: quantity,
  );

  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}

// Laundry item class
class LaundryItem extends Item {
  final List<String> services;

  LaundryItem({
    required int productId,
    required String name,
    required String price,
    String? image,
    required int quantity,
    required this.services,
  }) : super(
    productId: productId,
    name: name,
    price: price,
    image: image,
    quantity: quantity,
  );

  factory LaundryItem.fromJson(Map<String, dynamic> json) {
    return LaundryItem(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
      services: List<String>.from(json['services'] ?? []),
    );
  }
}