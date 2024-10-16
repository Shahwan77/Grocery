class LaundryCartItem {
  int productId;
  int quantity;
  List<String> services;

  LaundryCartItem({
    required this.productId,
    required this.quantity,
    required this.services,
  });

  // Method to convert the object to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'services': services,
    };
  }

  // Factory method to create a LaundryCartItem from JSON
  factory LaundryCartItem.fromJson(Map<String, dynamic> json) {
    return LaundryCartItem(
      productId: json['product_id'],
      quantity: json['quantity'],
      services: List<String>.from(json['services']),
    );
  }
}
