import 'package:get/get.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/models/models.dart';

class ProductsController extends GetxController {
  var productItems = <Models>[].obs;
  var isLoading = true.obs;



  @override
  void onInit() {
    // fetchPopularProducts();
    super.onInit();
  }

  Future<void> fetchProducts(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('${Api.BaseUrl}/api/products?category_id=$categoryId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          productItems.value = (data['data'] as List)
              .map((item) => Models.fromJson(item))
              .toList();
        }
      }
    }
    finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchPopularProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('${Api.BaseUrl}/api/products/popular'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          productItems.value = (data['data'] as List)
              .map((item) => Models.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      print("Error fetching popular products: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
