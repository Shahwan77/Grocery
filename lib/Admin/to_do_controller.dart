// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:grocery/data/apiClient/api.dart';
// import 'package:http/http.dart' as http;
//
// import '../data/models/admin_orderlist_model.dart';
//
// class OrderController extends GetxController {
//   var isLoading = false.obs;
//   var orders = <Orderlist>[].obs;
//   GetStorage box = GetStorage();
//   @override
//   void onInit() {
//     fetchAdminOrderlist();
//     super.onInit();
//   }
//
//   Future<void> fetchAdminOrderlist() async {
//     final String? token = box.read('access_token');
//     String Type = box.read('selectedButton')??'grocery';
//     isLoading.value = true;
//     try {
//       String apiUrl = (Type == 'grocery') ? Api.AdminOrdergrocery : Api.AdminOrderlaundry;
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//      // await Future.delayed(Duration(seconds: 2));
//       print('Response Status: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
//         if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
//           orders.value = (jsonResponse['data'] as List)
//               .map((orderJson) => Orderlist.fromJson(orderJson))
//               .toList();
//         } else {
//           Get.snackbar("Error", "Unexpected JSON structure");
//         }
//       } else {
//         Get.snackbar("Error", "Failed to load orders. Status Code: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to fetch orders");
//       print("Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
