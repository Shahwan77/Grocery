import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../OTP Field/otp_field.dart';

class SignupController extends GetxController {
  RxBool isChecked = false.obs;
  RxBool obsecure = true.obs;
  RxBool obsecureConfirm = true.obs;
  var showAlert = false.obs;
  var showOtpField = false.obs;
  var isLoading = false.obs;
  var selectedCountryCode = ''.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  void togglePasswordVisibility() {
    obsecure.value = !obsecure.value;
  }
  void toggleConfirmPasswordVisibility() {
    obsecureConfirm.value = !obsecureConfirm.value; // New method for confirm password toggle
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }


  Future<void> registerUser() async {
    if (_validateForm()) {
      isLoading.value = true;

      const String url = 'https://grocery-dev.greendomains.in/api/register';
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': nameController.text,
            'mobile_no': mobileNoController.text,
            'password': passwordController.text,
            'password_confirmation': passwordConfirmController.text,
          }),
        );

        // Debugging logs
        print("Request URL: $url");
        print("Request Body: ${jsonEncode({
          'name': nameController.text,
          'mobile_no': mobileNoController.text,
          'password': passwordController.text,
          'password_confirmation': passwordConfirmController.text,
        })}");
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 201) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          // Check response message
          if (responseData['message'] == 'User successfully registered') {
            showAlert.value = true;
            showOtpField.value = true;
            Get.to(() => OtpField());
            Get.snackbar('Success', 'User successfully registered',
                snackPosition: SnackPosition.BOTTOM);
          } else {
            Get.snackbar('Error', 'Registration failed. Try again.',
                snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          Get.snackbar('Error', 'Failed to register user. ${response.body}',
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e',
            snackPosition: SnackPosition.BOTTOM);
        print('Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }


  // Form validation logic
  bool _validateForm() {
    if (nameController.text.isEmpty ||
        mobileNoController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordConfirmController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (passwordController.text != passwordConfirmController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (!isChecked.value) {
      Get.snackbar('Error', 'Please agree to the terms',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileNoController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.onClose();
  }
}
