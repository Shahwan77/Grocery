import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import '../../data/models/promo_model.dart';

class PromoController extends GetxController {
  var promotionResponse = Rxn<PromotionResponse>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPromotion();  // Fetch data when the controller is initialized
  }

  Future<void> fetchPromotion() async {
    isLoading.value = true;
    errorMessage.value = '';
    final String? token = GetStorage().read('access_token');
    final String? promId = GetStorage().read('promotion_id');

    try {
      final response = await http.get(
        Uri.parse('https://grocery-dev.greendomains.in/api/promotions/$promId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true && jsonData['data'] != null) {
          promotionResponse.value = PromotionResponse.fromJson(jsonData);
          print("Data fetched successfully: ${jsonData['data']}");
        } else {
          errorMessage.value = 'No promotion data found';
        }
      } else {
        errorMessage.value = 'Failed to load promotion';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
