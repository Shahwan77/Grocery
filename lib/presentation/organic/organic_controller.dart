import 'package:get/get.dart';
import 'package:grocery/data/models/fruits&veg_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/models/bakery_models.dart';
import '../../data/models/organic_model.dart';

class OrganicFoodController extends GetxController {
  var organicItems = <OrganicItem>[].obs;
  var bakeryItems = <BakeryItem>[].obs;
  var vegItems=<VegItem>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchOrganicFoods(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('https://grocery-dev.greendomains.in/api/products?category_id=$categoryId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          organicItems.value = (data['data'] as List)
              .map((item) => OrganicItem.fromJson(item))
              .toList();
        } else {

          Get.snackbar('Error', 'Failed to load data');
        }
      } else {

        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {

      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
  Future<void> fetchBakery(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('https://grocery-dev.greendomains.in/api/products?category_id=$categoryId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          bakeryItems.value = (data['data'] as List)
              .map((item) => BakeryItem.fromJson(item))
              .toList();
        } else {

          Get.snackbar('Error', 'Failed to load data');
        }
      } else {

        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {

      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
  Future<void> fetchVeg(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('https://grocery-dev.greendomains.in/api/products?category_id=$categoryId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          vegItems.value = (data['data'] as List)
              .map((item) => VegItem.fromJson(item))
              .toList();
        } else {
          Get.snackbar('Error', 'Failed to load data');
        }
      } else {
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
