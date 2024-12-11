import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'forgot_password_otp_controller.dart';

class ResetPasswordController extends GetxController {
  final ForgotPasswordOtpController forgotController = Get.put(ForgotPasswordOtpController());
  RxBool isLoading = false.obs;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  Future<void> resetPassword() async {
    isLoading.value = true;

    final url = Uri.parse('${Api.ApiUrl}/reset-password');
    final body = {
      'mobile_no': forgotController.mobileNoController.text,
      'new_password': newPasswordController.text,
      'new_password_confirmation': confirmPasswordController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      isLoading.value = false;
      print("Siuuuuuuuu${body}");
      if (response.statusCode == 201) {
        print(response.body);
        final data =json.decode(response.body)['message'];
        Get.snackbar('Success', 'Password reset successfully!', snackPosition: SnackPosition.BOTTOM);
        Get.to(() => LoginPage());
      } else {
        final error = json.decode(response.body)['message'];
        Get.snackbar('rr', error, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to connect to server', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
