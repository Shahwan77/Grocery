// // controllers/in_progress_controller.dart
//
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import '../data/apiClient/api.dart';
// import '../data/models/in_progress_model.dart';
//
// class InProgressController extends GetxController {
//   var orders = <InProgressModel>[].obs;
//   var isLoading = true.obs;
//   GetStorage box = GetStorage();
//
//   @override
//   void onInit() {
//     fetchInProgressOrders();
//     super.onInit();
//   }
//
//   Future<void> fetchInProgressOrders() async {
//     final String? token = box.read('access_token');
//     String Type = box.read('selectedButton')??'grocery';
//     try {
//       String apiUrl = (Type == 'grocery') ? Api.AdminInOrdergrocery : Api.AdminInOrderlaundry;
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         print(response.body);
//         final jsonData = json.decode(response.body);
//         orders.assignAll((jsonData['data'] as List)
//             .map((orderJson) => InProgressModel.fromJson(orderJson))
//             .toList());
//       } else {
//         // Handle error here
//         orders.clear(); // Clear the orders if the response is not successful
//       }
//     } catch (e) {
//       print('Error fetching orders: $e');
//     } finally {
//       isLoading.value = false; // Set loading to false after fetching
//     }
//   }
// }
