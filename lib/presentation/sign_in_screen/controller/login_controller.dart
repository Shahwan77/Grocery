import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Cart/cart_controller.dart';
import '../../bottomnav/page/bottom_nav.dart';

class LoginController extends GetxController {
  var isNumberValid = false.obs;
  var isPasswordValid = false.obs;
  RxBool obsecure = true.obs;
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  final CartController cartController =
      Get.find<CartController>(); // Get CartController

  // Login method
  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse(Api.Login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile_no': numberController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('access_token') && data['access_token'] != null) {
          String accessToken = data['access_token'];
          box.write('access_token', accessToken);
           print('Access Token: $accessToken');
          Get.snackbar('Success', 'Login successful');
          GetStorage().write('status', '4');
          if (cartController.cartItems.isNotEmpty) {
            // Post each cart item after login
            for (var cartItem in cartController.cartItems) {
              await cartController.postCartItems(accessToken, cartItem);
            }
          }
          cartController.clearLocalCart();
          await Future.delayed(Duration(seconds: 1));
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
    // isMobileValid.value = GetUtils.isEmail(value);
    isNumberValid.value = value.isNotEmpty && value.length == 10;
    return isNumberValid.value ? null : 'Please enter a valid phone number';  }

  String? validatePassword(String value) {
    isPasswordValid.value = value.length >= 6;
    return isPasswordValid.value
        ? null
        : 'Password must be at least 6 characters long';
  }

  @override
  void onClose() {
    numberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
