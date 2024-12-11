import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;
  final TextEditingController addressController = TextEditingController();


  Future<void> postAddress() async {
   // const url = 'https://grocery-dev.greendomains.in/api/address';
    isLoading.value = true;
    final String token = GetStorage().read('access_token');
    try {
      final response = await http.post(
        Uri.parse("${Api.ApiUrl}/address"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"address": addressController.text}),
      );

      if (response.statusCode == 201) {
        Get.back();
        responseMessage.value = "Address updated successfully!";
      } else {
        responseMessage.value =
        "Failed to post address: ${response.statusCode}";
      }
    } catch (e) {
      responseMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }
}