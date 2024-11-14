// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class SearchController extends GetxController {
//   var isLoading = false.obs;
//   var productList = <Product>[].obs;
//
//   Future<void> searchProducts(String query) async {
//     isLoading.value = true;
//     final url = 'https://grocery-dev.greendomains.in/api/products/search?shop_id=1&type=grocery&name=$query';
//
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success'] == true) {
//           var products = data['data'] as List;
//           productList.value = products.map((product) => Product.fromJson(product)).toList();
//         }
//       } else {
//         Get.snackbar("Error", "Failed to fetch products");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
//
// class Product {
//   final int id;
//   final String name;
//   final String type;
//   final String image;
//   final double price;
//
//   Product({required this.id, required this.name, required this.type, required this.image, required this.price});
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       type: json['type'],
//       image: json['image'],
//       price: double.parse(json['price']),
//     );
//   }
// }
