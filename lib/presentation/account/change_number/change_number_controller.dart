import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:grocery/presentation/account/change_number/change_number_otp_controller.dart';
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'package:http/http.dart' as http;

class ChangeNumberController extends GetxController {
  final ChangeNumberOtpController forgotController = Get.put(ChangeNumberOtpController());
  RxBool isLoading = false.obs;
  final TextEditingController mobileNoController = TextEditingController();

  Future<void> changeNumber() async {
    isLoading.value = true;
    final String token = GetStorage().read('access_token');
    final url = Uri.parse('${Api.ApiUrl}/mobile');
    final body = {
      'mobile_no': mobileNoController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Pass the token here
        },
        body: json.encode(body),
      );

      isLoading.value = false;
print(body);
      if (response.statusCode == 201) {
        final data = json.decode(response.body)['message'];
        print(response.body);
        Get.snackbar('Success', 'Mobile updated successfully', snackPosition: SnackPosition.BOTTOM);
        Get.to(LoginPage());
      } else {
        final error = json.decode(response.body)['message'];
        Get.snackbar('Error', error, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to connect to server', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
