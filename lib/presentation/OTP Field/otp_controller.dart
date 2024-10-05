import 'dart:async';
import 'package:get/get.dart';

class OtpController extends GetxController {
  RxInt remainingTime = 60.obs; // 60 seconds
  Timer? timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    remainingTime.value = 60; // Reset the timer
    startTimer(); // Restart the timer
    // Add your OTP resend logic here
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
