import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import '../../data/models/my_order_model.dart';
import '../../data/models/my_orderview_model.dart';
import '../../data/models/order_model.dart';

class MyOrderController extends GetxController {
  GetStorage box = GetStorage();

  Future<List<myOrder>> fetchOrder() async {
    final String? token = box.read('access_token');
    final String? type = box.read('selectedButton')??'grocery';
    final String? selectedShopId = GetStorage().read('selected_shop_id');

    final response = await http.get(
      Uri.parse('${Api.ApiUrl}/orders?shop_id=1&type=$type'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        List<myOrder> orders = (jsonResponse['data'] as List)
            .map((orderData) => myOrder.fromJson(orderData))
            .toList();
        return orders;
      } else {
        throw Exception('Failed to load order data');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }
  Future<Orderview> fetchOrderview(String orderId) async {
    final String? token = box.read('access_token');
    final response = await http.get(
      Uri.parse('${Api.ApiUrl}/orders/$orderId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        return Orderview.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load order data');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }
}
