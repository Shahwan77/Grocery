import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/presentation/account/change_number/change_number.dart';
import '../../../../data/apiClient/api.dart'; // If needed for further integrations
import 'package:http/http.dart' as http;


class ChangeNumberOtpController extends GetxController {
  RxBool isLoading = false.obs;
  var verificationId = ''.obs;
  RxBool isOtpVisible = false.obs;
  var selectedCountryCode = ''.obs; // Store country code (optional for international numbers)
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  // Start OTP Verification
  Future<void> startOtpVerification() async {
    if (_validateMobileForm()) {
      isLoading.value = true;
      await sendOtp();
      isLoading.value = false;
      isOtpVisible.value = true;
    }
  }

  // Method to send OTP
  Future<void> sendOtp() async {
    final phoneNumber = '${selectedCountryCode.value}${mobileNoController.text}'; // Mobile number with country code
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Get.snackbar('Success', 'Phone number verified!',
              snackPosition: SnackPosition.BOTTOM);
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

  // Verify OTP and reset password
  Future<void> verifyOtpAndResetPassword() async {
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
      Get.to(ChangeNumber());

      // Now reset password
      //await resetPassword();
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP: $e',
          snackPosition: SnackPosition.BOTTOM);
      print('Error: $e');
    }
  }

  // Reset the password after OTP verification


  // Form validation for mobile number input
  bool _validateMobileForm() {
    if (mobileNoController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your mobile number.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  // Validate new password fields
  // bool _validatePasswordForm(String password, String confirmPassword) {
  //   if (password.isEmpty || confirmPassword.isEmpty) {
  //     Get.snackbar('Error', 'Please fill both password fields.',
  //         snackPosition: SnackPosition.BOTTOM);
  //     return false;
  //   }
  //   if (password != confirmPassword) {
  //     Get.snackbar('Error', 'Passwords do not match.',
  //         snackPosition: SnackPosition.BOTTOM);
  //     return false;
  //   }
  //   return true;
  // }

  @override
  void onClose() {
    mobileNoController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
