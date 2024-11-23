// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class OrderController extends GetxController {
//   var orders = [].obs;
//   var isLoading = false.obs;
//   final String token = '493|WtS5wmaEnzVeJq8vfAQ6X4zXNDk9O9Q6MpxzgtOn31a97185';
//
//   Future<void> fetchtabOrders() async {
//     isLoading.value = true;
//     try {
//       final response = await http.get(
//         Uri.parse('https://grocery-dev.greendomains.in/api/admin/orders?shop_id=1&type=grocery&status=unassigned'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success']) {
//           orders.value = data['data'];
//         }
//       } else {
//         print('Failed to load orders');
//       }
//     } catch (e) {
//       print('Error fetching orders: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
