import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/widgets/button/button.dart';
import 'package:pinput/pinput.dart';

import '../Language Selection/language_controller.dart';
import '../sign_up_screen/controller/signup_controller.dart';
import 'otp_controller.dart';

class OtpField extends StatelessWidget {
  OtpField({super.key});
  final SignupController signupController = Get.put(SignupController());
  final OtpController otpTimerController = Get.put(OtpController());
  final TextEditingController otpController = TextEditingController();
  final WelcomeController languagecontroller = Get.put(WelcomeController());


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor:Color(0xFFEB1C23),
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
              height: 22.h,
              width: 26.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
              child: Center(
                child: Icon(Icons.arrow_back_ios_rounded,
                    color: Color(0xFFEB1C23), size: 20.sp),
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFFEB1C23),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                languagecontroller.verificationText,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                    color: Colors.white),
              ),
              SizedBox(height: 10.h),
              SvgPicture.asset(
                'assets/otp.svg',
                height: 84.h,
                color: Colors.white,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 450.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.r), topLeft: Radius.circular(30.r)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  '00:${otpTimerController.remainingTime.value} secs',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                );
              }),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Pinput(
                  length: 6,
                  controller: signupController.otpController,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                languagecontroller.enterOTPsentText,
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              Text(
                '${signupController.selectedCountryCode.value} ${signupController.mobileNoController.text}',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                return Button(
                  text: signupController.isLoading.value
                      ? Text(
                    'Verifying...', // Displaying text when OTP is being verified
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    languagecontroller.verifyText, // Display the original button text
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  size: Size(280.w, 46.h),
                  color: signupController.isLoading.value
                      ? Colors.grey // Button color when verifying
                      : Color(0xFFEB1C23), // Normal button color
                  ontap: signupController.isLoading.value
                      ? null // Disable button when verifying
                      : () {
                    signupController.verifyOtpAndRegister(); // Trigger OTP verification
                  },
                );
              }),




              SizedBox(height: 20.h),
              Obx(() {
                return TextButton(
                  onPressed: otpTimerController.isTimerRunning.value
                      ? null
                      : () {
                    signupController.sendOtp();
                    otpTimerController.startTimer();
                  },
                  child: Text(
                    languagecontroller.resendOTPText,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFFEB1C23),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}


