import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../Admin/orders_list.dart';
import '../../Cart/cart_controller.dart';
import '../../bottomnav/page/bottom_nav.dart';

class LoginController extends GetxController {
  var isNumberValid = false.obs;
  var isPasswordValid = false.obs;
  var isSelected = false.obs;
  RxBool obsecure = true.obs;
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  final CartController cartController =
  Get.find<CartController>(); // Get CartController

  void toggleSelection() {
    isSelected.value = !isSelected.value; // Toggle the selection state
  }

  // Login method
  Future<void> login() async {
    try {
      String? fcmToken = GetStorage().read('fcm_token');
      final response = await http.post(
        Uri.parse(Api.Login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile_no': numberController.text,
          'password': passwordController.text,
          'fcm_token': fcmToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);

        // Log the entire data object for debugging
        if (data is Map<String, dynamic>) {
          String? accessToken = data['access_token'];
          String? userType = data['user_type'];
          Map<String, dynamic>? user = data['user'];
          print('Access Token: $accessToken');
          print('User Type: $userType');
          print(user);
          if (accessToken != null && userType != null && user!= null) {
            box.write('access_token', accessToken);
            box.write('user_type', userType);
            box.write('user', user);
            print("USErrrrrrrr");
            if (user.containsKey('id') && user.containsKey('shop_id')) {
              // Storing the user ID and shop ID
              box.write('user_id', user['id']);
              box.write('shop_id', user['shop_id']);
            }
            box.write('isLoggedIn', true);
            Get.snackbar('Success', 'Login successful');
            GetStorage().write('status', '4');

            // Removed the userType check and navigation logic
            if (cartController.cartItems.isNotEmpty) {
              for (var cartItem in cartController.cartItems) {
                await cartController.postCartItems( cartItem,); // or 'laundry'
               // print(cartController.postCartItems(accessToken, cartItem, 'grocery'));
              }
            }

            cartController.clearLocalCart();
            await Future.delayed(Duration(seconds: 1));
            Get.offAll(() => CustomBottomNavBar());
          } else {
            Get.snackbar('Error', 'Login failed: Access token or user type not found');
          }
        } else {
          Get.snackbar('Error', 'Login failed: Unexpected response format');
        }
      } else {
        Get.snackbar('Error', 'Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
      print("${e.toString()}");
    }
  }



  String? validateEmail(String value) {
    isNumberValid.value = value.isNotEmpty && value.length == 10;
    return isNumberValid.value ? null : 'Please enter a valid phone number';
  }

  String? validatePassword(String value) {
    isPasswordValid.value = value.length >= 8;
    return isPasswordValid.value
        ? null
        : 'Password must be at least 8 characters long';
  }

  @override
  void onClose() {
    numberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
