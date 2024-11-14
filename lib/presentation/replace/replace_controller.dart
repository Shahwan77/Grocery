import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import '../../data/apiClient/api.dart';
import '../../data/models/replace_model.dart';

class MissingItemController extends GetxController {
  final int itemId;
  MissingItemController(this.itemId);

  Future<ReplaceOrder?> fetchOrder() async {
    final String token = GetStorage().read('access_token'); // Replace with your actual token
    final response = await http.get(
      Uri.parse('${Api.ApiUrl}/orders/replace/$itemId'), // Use itemId in the URL
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    // print(itemId);

    if (response.statusCode == 200) {
      print(response.body);
      print(itemId);
      final data = json.decode(response.body);
      ResponseModel responseModel = ResponseModel.fromJson(data);
      return responseModel.data; // Return the order data
    } else {
      throw Exception('Failed to load order');
    }
  }
}
