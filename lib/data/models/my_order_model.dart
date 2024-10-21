// class Item {
//   final int productId;
//   final String name;
//   final String price;
//   final String image;
//   final int quantity;
//
//   Item({
//     required this.productId,
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.quantity,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       productId: json['product_id'],
//       name: json['name'],
//       price: json['price'],
//       image: json['image'],
//       quantity: json['quantity'],
//     );
//   }
// }
//
// class Order {
//   final List<Item> items;
//   final String totalAmount;
//   final int totalQuantity;
//   final String deliveryDate;
//   final String deliveryTime;
//   final String paymentMethod;
//   final String paymentChange;
//
//   Order({
//     required this.items,
//     required this.totalAmount,
//     required this.totalQuantity,
//     required this.deliveryDate,
//     required this.deliveryTime,
//     required this.paymentMethod,
//     required this.paymentChange,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     var itemsJson = json['data']['items'] as List;
//     List<Item> itemsList = itemsJson.map((item) => Item.fromJson(item)).toList();
//
//     return Order(
//       items: itemsList,
//       totalAmount: json['data']['total_amount'],
//       totalQuantity: json['data']['total_quantity'],
//       deliveryDate: json['data']['delivery_date'],
//       deliveryTime: json['data']['delivery_time'],
//       paymentMethod: json['data']['payment_method'],
//       paymentChange: json['data']['payment_change'],
//     );
//   }
// }
