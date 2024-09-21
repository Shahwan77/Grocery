import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Cart/cart_controller.dart';
import '../../bottomnav/page/bottom_nav.dart';

class LoginController extends GetxController {
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;
  RxBool obsecure = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  final CartController cartController = Get.find<CartController>();

  // Login method
  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse(Api.Login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('access_token') && data['access_token'] != null) {
          String accessToken = data['access_token'];
          String tokenType = data['token_type'];

          print('Access Token: $accessToken');

          box.write('access_token', accessToken);
          box.write('token_type', tokenType);

          Get.snackbar('Success', 'Login successful');

          if (cartController.uniqueItemCount > 0) {
            await cartController.postCartItems(accessToken);
          }
          // cartController.postCartItems(accessToken);
          Get.offAll(CustomBottomNavBar());
        } else {
          Get.snackbar('Error', 'Login failed: Access token not found');
        }
      } else {
        Get.snackbar('Error', 'Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  String? validateEmail(String value) {
    isEmailValid.value = GetUtils.isEmail(value);
    return isEmailValid.value ? null : 'Please enter a valid email';
  }

  String? validatePassword(String value) {
    isPasswordValid.value = value.length >= 6;
    return isPasswordValid.value
        ? null
        : 'Password must be at least 6 characters long';
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
