import 'package:get/get.dart';

class BakeryItem {
  final int id;
  final String name;
  final String image;
  final String price;

  BakeryItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory BakeryItem.fromJson(Map<String, dynamic> json) {
    return BakeryItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
    );
  }
}
