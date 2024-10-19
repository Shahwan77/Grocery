import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/apiClient/api_service.dart';
import '../../data/models/models.dart';

class ProductsController extends GetxController {
  var productItems = <Models>[].obs;
  var isLoading = true.obs;
  final ApiService apiService = ApiService();
  GetStorage Box = GetStorage();
  var selectedServices = <int, List<int>>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Models>> fetchProducts(int categoryId) async {
    final type = Box.read('selectedButton'); // Read 'type' here
    try {
      isLoading.value = true;
      productItems.value = await apiService.fetchCategoryProducts(categoryId, type); // Pass 'type'
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
    final type = Box.read('selectedButton'); // Read 'type' here
    try {
      isLoading.value = true;
      productItems.value = await apiService.fetchTabs(subcategoryId, type); // Pass 'type'
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
    final type = Box.read('selectedButton'); // Read 'type' here
    try {
      isLoading.value = true;
      productItems.value = await apiService.fetchSubcategories(categoryId, type); // Pass 'type'
      return productItems;
    } catch (e) {
      print('Error: $e');
      productItems.value = [];
      return [];
    } finally {
      isLoading.value = false;
    }
  }
  void clearCheckboxes() {
    selectedServices.clear();
    selectedServices.refresh(); // To update the UI if needed
  }
  void toggleServiceSelection(int productId, int serviceId, bool isSelected) {
    if (isSelected) {
      if (selectedServices[productId] == null) {
        selectedServices[productId] = [];
      }
      selectedServices[productId]!.add(serviceId);
    } else {
      selectedServices[productId]?.remove(serviceId);
    }
    selectedServices.refresh();
  }

  String calculateTotalPrice(Models item) {
    print('Item Price: ${item.price}');

    // Parse the item price from string to double
    double itemPrice = double.tryParse(item.price) ?? 0.0;
    print('Parsed Item Price: $itemPrice');

    // Initialize total price with item price
    double totalPrice = itemPrice;

    // Check if selected services and item services are valid
    if (selectedServices[item.id] != null && item.services != null) {
      print('Selected Services for ${item.id}: ${selectedServices[item.id]}');

      for (var service in item.services!) {
        // Print each service before checking
        print('Checking Service ID: ${service.id}, Service Price: ${service.price}');

        // Ensure the service ID is part of the selected services
        if (selectedServices[item.id]!.contains(service.id)) {
          // Safely parse service price
          double servicePrice = double.tryParse(service.price) ?? 0.0;
          print('Adding Service Price: $servicePrice');
          totalPrice += servicePrice; // Add the service price
          print('Updated Total Price: $totalPrice');
        } else {
          print('Service ID ${service.id} is not selected.');
        }
      }
    } else {
      print('No selected services or item services are null.');
    }

    // Return the total price as a string formatted to 2 decimal places
    String totalPriceString = totalPrice.toStringAsFixed(2);
    print('Total Price Calculated: $totalPriceString');
    return totalPriceString;
  }




}
