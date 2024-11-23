import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import '../../data/apiClient/api.dart';
import '../../data/models/models.dart';

class SearchPoductController extends GetxController {
  var isLoading = false.obs;
  var popularProducts = <Models>[].obs;
  final TextEditingController searchTextController = TextEditingController();

  Future<void> searchProducts(String query) async {
    isLoading.value = true;
    String Type = GetStorage().read('selectedButton')??'grocery';
    final String? selectedShopId = GetStorage().read('selected_shop_id');

    final url = '${Api.ApiUrl}/products/search?shop_id=$selectedShopId&type=$Type&name=$query';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          var products = data['data'] as List;
          popularProducts.value = products.map((product) => Models.fromJson(product)).toList();
        }
      } else {
        popularProducts.clear();
      }
    } catch (e) {
     // Get.snackbar("Error", "An error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}


