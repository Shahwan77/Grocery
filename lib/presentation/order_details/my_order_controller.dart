// import 'dart:convert';
//
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:http/http.dart' as http;
// import '../../data/models/order_model.dart';
//
// class MyOrderController extends GetxController {
//   get box => null;
//
//
//   Future<Order> fetchOrder() async {
//     final String? token = box.read('access_token');
//     final String? type = box.read('selectedButton');
//     final response = await http.get(
//       Uri.parse('https://grocery-dev.greendomains.in/api/order?type=$type'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);
//       if (jsonResponse['success']) {
//         return Order.fromJson(jsonResponse);
//       } else {
//         throw Exception('Failed to load order data');
//       }
//     } else {
//       throw Exception('Failed to fetch data: ${response.statusCode}');
//     }
//   }
// }
