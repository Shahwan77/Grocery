import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;
  RxBool obsecure = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String validateEmail(String value) {
    isEmailValid.value = value.contains('@gmail.com');
    return 'Password must be at least 8 characters long';

  }
  String? validatePassword(String value) {
    if (value.length < 7) {
      return 'Password must be at least 7 characters long';
    }
    if (!value.contains(RegExp(r'[a-z]')) ||
        !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must include both upper and lower case letters';
    }
    return null; // Return null if validation is successful
  }


  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    obsecure.value = !obsecure.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
