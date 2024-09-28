import 'package:get/get.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/apiClient/api_service.dart';
import '../../data/models/models.dart';

class ProductsController extends GetxController {
  var productItems = <Models>[].obs;
  var isLoading = true.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Models>> fetchProducts(int categoryId) async {
    try {
      isLoading.value = true;
      productItems.value = await apiService.fetchCategoryProducts(categoryId);
      return productItems;
    } catch (e) {
      print('Error: $e');
      productItems.value = [];
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Models>> fetchTabs(int subcategoryId) async {
    try {
      isLoading.value = true;
      productItems.value = await apiService.fetchTabs(subcategoryId);
      return productItems;
    } catch (e) {
      print('Error: $e');
      productItems.value = [];
      return [];
    } finally {
      isLoading.value = false;
    }
  }
  Future<List<Models>> fetchSubcategories(int categoryId) async {
    try {
      isLoading.value = true;
      productItems.value = await apiService.fetchSubcategories(categoryId);
      return productItems;
    } catch (e) {
      print('Error: $e');
      productItems.value = [];
      return [];
    } finally {
      isLoading.value = false;
    }
  }
}
