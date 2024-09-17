import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../data/models/category_model.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs; // Observable list of categories
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCategories(); // Fetch categories when the controller is initialized
    super.onInit();
  }

  Future<void> fetchCategories() async {
    const url = 'https://grocery-dev.greendomains.in/api/product-categories';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        categories.value = data.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Stop the loader once data is fetched
    }
  }
}