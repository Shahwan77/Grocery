import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;

import '../../data/models/category_model.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse("${Api.BaseUrl}/api/product-categories"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        categories.value = data.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } finally {
      isLoading.value = false;
    }
  }
}