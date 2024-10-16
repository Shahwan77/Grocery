// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../../data/apiClient/api.dart'; // Adjust the path as necessary
//
// class LaundryCartController extends GetxController {
//   var laundryItems = <Map<String, dynamic>>[].obs;
//   var totalAmount = "0.00".obs;
//   var totalQuantity = "0".obs;
//   final box = GetStorage();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadLaundryItems();
//   }
//
//   void loadLaundryItems() {
//     final savedItems = box.read('laundryItems');
//     if (savedItems != null) {
//       laundryItems.assignAll(List<Map<String, dynamic>>.from(savedItems));
//     }
//   }
//
//   void saveLaundryItems() {
//     box.write('laundryItems', laundryItems);
//   }
//
//   void clearLocalLaundryCart() {
//     laundryItems.clear();
//     box.remove('laundryItems');
//   }
//
//   int get uniqueItemCount => laundryItems.length;
//
//   int get itemCount => laundryItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
//
//   Future<void> addToLaundryCart(int productId, int quantity, List<String> services) async {
//     final existingItemIndex = laundryItems.indexWhere((item) => item['product_id'] == productId);
//
//     if (existingItemIndex >= 0) {
//       laundryItems[existingItemIndex]['quantity'] += quantity;
//     } else {
//       final newItem = {
//         'product_id': productId,
//         'quantity': quantity,
//         'services': services,
//       };
//       laundryItems.add(newItem);
//     }
//
//     saveLaundryItems();
//     await postLaundryItems();
//   }
//
//   Future<void> removeFromLaundryCart(int productId) async {
//     final itemIndex = laundryItems.indexWhere((item) => item['product_id'] == productId);
//     if (itemIndex >= 0) {
//       laundryItems.removeAt(itemIndex);
//       saveLaundryItems();
//       await postLaundryItems(); // Update server
//     }
//   }
//
//   Future<void> updateQuantity(int productId, int change) async {
//     final itemIndex = laundryItems.indexWhere((item) => item['product_id'] == productId);
//     if (itemIndex >= 0) {
//       laundryItems[itemIndex]['quantity'] += change;
//       if (laundryItems[itemIndex]['quantity'] <= 0) {
//         laundryItems.removeAt(itemIndex);
//       }
//       saveLaundryItems();
//       await postLaundryItems(); // Update server
//     }
//   }
//
//   Future<void> postLaundryItems() async {
//     final token = box.read('access_token');
//     if (token == null) return;
//
//     try {
//       final response = await http.post(
//         Uri.parse('https://grocery-dev.greendomains.in/api/cart'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           "type": "laundry",
//           "items": laundryItems.map((item) => {
//             "product_id": item['product_id'],
//             "quantity": item['quantity'],
//             "services": item['services'],
//           }).toList(),
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success']) {
//           Get.snackbar('Success', 'Laundry cart updated successfully.');
//           // Optionally fetch the updated cart data or update total amount and quantity
//         } else {
//           Get.snackbar('Error', 'Failed to update laundry cart: ${data['message']}');
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to post laundry items: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while posting laundry items: $e');
//     }
//   }
//
//   bool isLoggedIn() {
//     final accessToken = box.read('access_token');
//     return accessToken != null && accessToken.isNotEmpty;
//   }
// }
