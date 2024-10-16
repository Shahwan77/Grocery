class Cart {
  String type;
  List<Item> items;

  Cart({
    required this.type,
    required this.items,
  });

  // Factory constructor to create a Cart object from JSON
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      type: json['type'],
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
    );
  }

  // Method to convert Cart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class Item {
  int productId;
  int quantity;
  List<String>? services; // Nullable, as services might not be present for "grocery"

  Item({
    required this.productId,
    required this.quantity,
    this.services,
  });

  // Factory constructor to create an Item object from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      productId: json['product_id'],
      quantity: json['quantity'],
      services: json['services'] != null
          ? List<String>.from(json['services'])
          : null, // Handle null for "grocery" items
    );
  }

  // Method to convert Item object to JSON
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      if (services != null) 'services': services,
    };
  }
}
