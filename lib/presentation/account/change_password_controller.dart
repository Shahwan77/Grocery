import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordController extends GetxController {
  var isCurrentPasswordValid = false.obs;
  var isNewPasswordValid = false.obs;
  var isConfirmPasswordValid = false.obs;
  var isPasswordChangeInProgress = false.obs;
  var errorMessage = ''.obs;

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final box = GetStorage();

  Future<void> changePassword() async {
    try {
      if (newPasswordController.text != confirmPasswordController.text) {
        errorMessage.value = 'Passwords do not match';
       // Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      isPasswordChangeInProgress.value = true;
      errorMessage.value = '';

      final String? token = box.read('access_token');
      if (token == null) {
       // Get.snackbar('Error', 'No access token found', snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final response = await http.post(
        Uri.parse('${Api.ApiUrl}/change-password'), // Replace with the actual API endpoint
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'current_password': currentPasswordController.text,
          'new_password': newPasswordController.text,
          'new_password_confirmation': confirmPasswordController.text,
        }),
      );

      isPasswordChangeInProgress.value = false;

      if (response.statusCode == 201) {
        Get.back();
        final data = jsonDecode(response.body);
        //Get.snackbar('Success', 'Password changed successfully', snackPosition: SnackPosition.BOTTOM);
        // Clear fields or handle success
      } else {
        final data = jsonDecode(response.body);
        errorMessage.value = data['message'] ?? 'Failed to change password';
        //Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isPasswordChangeInProgress.value = false;
      errorMessage.value = 'An error occurred: ${e.toString()}';
      //Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      print(e.toString());
    }
  }

  // Validation methods for password fields
  String? validateCurrentPassword(String value) {
    isCurrentPasswordValid.value = value.isNotEmpty;
    return isCurrentPasswordValid.value ? null : 'Please enter your current password';
  }

  String? validateNewPassword(String value) {
    isNewPasswordValid.value = value.length >= 8;
    return isNewPasswordValid.value ? null : 'New password must be at least 6 characters long';
  }

  String? validateConfirmPassword(String value) {
    isConfirmPasswordValid.value = value == newPasswordController.text;
    return isConfirmPasswordValid.value ? null : 'Passwords do not match';
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
