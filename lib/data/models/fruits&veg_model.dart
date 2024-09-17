import 'package:get/get.dart';

class VegItem {
  final int id;
  final String name;
  final String image;
  final String price;

  VegItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory VegItem.fromJson(Map<String, dynamic> json) {
    return VegItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
    );
  }
}
