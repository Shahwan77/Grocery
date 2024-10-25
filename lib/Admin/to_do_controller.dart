import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/models/admin_orderlist_model.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var orders = <Orderlist>[].obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('https://grocery-dev.greendomains.in/api/admin/orders?shop_id=1&type=grocery'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer 474|mo7xMy3xgCxTffLvpiQJpJJWS8WK7PvqMLCiUUjmfeb0f1b9',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          orders.value = (jsonResponse['data'] as List)
              .map((orderJson) => Orderlist.fromJson(orderJson))
              .toList();
        } else {
          Get.snackbar("Error", "Unexpected JSON structure");
        }
      } else {
        Get.snackbar("Error", "Failed to load orders. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch orders");
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
