import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool isChecked = false.obs;
  RxBool obsecure = true.obs;
  var showAlert = false.obs;
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    obsecure.value = !obsecure.value;
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
