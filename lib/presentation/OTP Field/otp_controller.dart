import 'package:get/get.dart';
import 'dart:async';

class OtpController extends GetxController {
  var isTimerRunning = false.obs;
  var remainingTime = 60.obs; // OTP valid for 30 seconds

  void startTimer() {
    isTimerRunning.value = true;
    remainingTime.value = 60;

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        isTimerRunning.value = false;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
