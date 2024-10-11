import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

import '../../../data/models/register_model.dart';
import '../../Cart/cart_controller.dart';
import '../../OTP Field/otp_field.dart';
import '../../home_screen/page/home_page.dart';

class SignupController extends GetxController {
  RxBool isChecked = false.obs;
  RxBool obsecure = true.obs;
  RxBool obsecureConfirm = true.obs;
  var showAlert = false.obs;
  var showOtpField = false.obs;
  var isLoading = false.obs;
  var selectedCountryCode = ''.obs;
  var verificationId = ''.obs;
  var isRegistrationSuccessful = false.obs;
  final CartController cartController =
  Get.find<CartController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // List to keep track of registered mobile numbers
  final List<String> registeredMobileNumbers = [];

  void togglePasswordVisibility() {
    obsecure.value = !obsecure.value;
  }

  void toggleConfirmPasswordVisibility() {
    obsecureConfirm.value = !obsecureConfirm.value;
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }

  // Send OTP without registering the user
  Future<void> startOtpVerification() async {
    if (_validateForm()) {
      // final phoneNumber = mobileNoController.text;
      // if (registeredMobileNumbers.contains(phoneNumber)) {
      //   Get.snackbar('Error', 'This mobile number is already registered.',
      //       snackPosition: SnackPosition.BOTTOM);
      //   return; // Stop the registration process
      // }
      isLoading.value = true;
      await sendOtp();
      showOtpField.value = true; // Show OTP field after sending OTP
      isLoading.value = false;
      GetStorage().write('status', '4');
      Get.to(() => OtpField());
    }
  }

  // Method to send OTP
  Future<void> sendOtp() async {
    final phoneNumber = '${selectedCountryCode.value}${mobileNoController.text}';
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Get.snackbar('Success', 'Phone number verified!',
              snackPosition: SnackPosition.BOTTOM);
          await registerUser(); // Automatically register user on verification
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Failed to verify phone number: ${e.message}',
              snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          Get.snackbar('OTP Sent', 'An OTP has been sent to your mobile number.',
              snackPosition: SnackPosition.BOTTOM);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while sending OTP: $e',
          snackPosition: SnackPosition.BOTTOM);
      print('Error: $e');
    }
  }

  // Verify OTP and then register the user
  Future<void> verifyOtpAndRegister() async {
    final String otp = otpController.text.trim();
    if (otp.isEmpty) {
      Get.snackbar('Error', 'Please enter the OTP.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp);

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.snackbar('Success', 'Phone number verified successfully!',
          snackPosition: SnackPosition.BOTTOM);

      await registerUser(); // Register the user only after OTP verification
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP: $e',
          snackPosition: SnackPosition.BOTTOM);
      print('Error: $e');
    }
  }

  Future<void> registerUser() async {
    isLoading.value = true;

    //const String url = 'https://grocery-dev.greendomains.in/api/register';
    try {
      final response = await http.post(
        Uri.parse(Api.Register),
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

      if (response.statusCode == 201) {
        isRegistrationSuccessful.value = true;
        // Parse the response
        final registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));

        // Access the token
        String? accessToken = registerResponse.user.accessToken;

        // Store the access token (you can use GetStorage for this)
        await GetStorage().write('access_token', accessToken);

        Get.snackbar('Success', 'Registration successful!',
            snackPosition: SnackPosition.BOTTOM);

        if (cartController.cartItems.isNotEmpty) {
          // Post each cart item after login
          for (var cartItem in cartController.cartItems) {
            await cartController.postCartItems(accessToken!, cartItem);
          }
        }

        // Add mobile number to registered list
        registeredMobileNumbers.add(mobileNoController.text);

        print('Registered User Details:');
        print('Name: ${nameController.text}');
        print('Mobile No: ${mobileNoController.text}');
        Get.offAll(() => CustomBottomNavBar()); // Replace HomePage with your desired page
      } else {
        Get.snackbar('Error', 'Failed to register user: ${response.body}',
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
    otpController.dispose();
    super.onClose();
  }
}
