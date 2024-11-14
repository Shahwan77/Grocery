// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import 'data/apiClient/api.dart';
//
// class PromoPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Promotions'),
//       ),
//       body: GetX<PromotionController>(
//         init: PromotionController(),
//         builder: (controller) {
//           if (controller.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (controller.errorMessage.value.isNotEmpty) {
//             return Center(child: Text(controller.errorMessage.value));
//           }
//           return ListView.builder(
//             itemCount: controller.promotions.length,
//             itemBuilder: (context, index) {
//               var promotion = controller.promotions[index];
//               return Image.network('${Api.ImageUrl}/promotions/${promotion.banner}');
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// class PromotionController extends GetxController {
//   var promotions = <Promotion>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//
//   // Token for Authorization
//   final String token = '884|R3GiZ08wFtLAAgp5k9yqdaZC2ZJ7EyUuF17rQOrr3fbbf201';
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchPromotions();
//   }
//
//   Future<void> fetchPromotions() async {
//     isLoading.value = true;
//     try {
//       final response = await http.get(
//         Uri.parse('https://grocery-dev.greendomains.in/api/promotions?shop_id=1&type=grocery'),
//         headers: {
//           'Authorization': 'Bearer $token', // Pass the token here
//         },
//       );
//
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         var promotionsList = (jsonResponse['data'] as List)
//             .map((promotion) => Promotion.fromJson(promotion))
//             .toList();
//         promotions.assignAll(promotionsList);
//       } else {
//         errorMessage.value = 'Failed to load promotions';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
// class Promotion {
//   final int id;
//   final String promotionId;
//   final String name;
//   final String description;
//   final String status;
//   final String start;
//   final String end;
//   final String banner;
//   final List<Item> items;
//
//   Promotion({
//     required this.id,
//     required this.promotionId,
//     required this.name,
//     required this.description,
//     required this.status,
//     required this.start,
//     required this.end,
//     required this.banner,
//     required this.items,
//   });
//
//   factory Promotion.fromJson(Map<String, dynamic> json) {
//     var list = json['items'] as List;
//     List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();
//
//     return Promotion(
//       id: json['id'],
//       promotionId: json['promotion_id'],
//       name: json['name'],
//       description: json['description'],
//       status: json['status'].toString(),
//       start: json['start'],
//       end: json['end'],
//       banner: json['banner'],
//       items: itemsList,
//     );
//   }
// }
//
// class Item {
//   final int id;
//   final int productId;
//   final String discountType;
//   final String discountValue;
//   final String promotionPrice;
//   final Product product;
//
//   Item({
//     required this.id,
//     required this.productId,
//     required this.discountType,
//     required this.discountValue,
//     required this.promotionPrice,
//     required this.product,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       id: json['id'],
//       productId: json['product_id'],
//       discountType: json['discount_type'],
//       discountValue: json['discount_value'],
//       promotionPrice: json['promotion_price'],
//       product: Product.fromJson(json['product']),
//     );
//   }
// }
//
// class Product {
//   final int id;
//   final String name;
//   final String image;
//   final String price;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       price: json['price'],
//     );
//   }
// }
