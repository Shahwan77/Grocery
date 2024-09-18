import 'package:get/get.dart';

class Models {
  final int id;
  final String name;
  final String image;
  final String price;

  Models({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Models.fromJson(Map<String, dynamic> json) {
    return Models(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
    );
  }
}
