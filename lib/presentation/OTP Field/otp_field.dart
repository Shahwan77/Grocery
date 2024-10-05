import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/widgets/button/button.dart';
import 'package:pinput/pinput.dart';

import '../sign_up_screen/controller/signup_controller.dart';
import 'otp_controller.dart';

class OtpField extends StatelessWidget {
  OtpField({super.key});
  final SignupController signupController = Get.put(SignupController());
  final OtpController otpTimerController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            height: 22.h,
            width: 26.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
            child: Center(
              child: Icon(Icons.arrow_back_ios_rounded,
                  color: Colors.red, size: 20.sp),
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Verification',
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
                style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Pinput(
                length: 6,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Enter the OTP sent to',
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

            SizedBox(
              height: 20.h,
            ),
            Button(
              text: Text(
                'Verify',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              size: Size(280.w, 46.h),
              color: Colors.red,
              ontap: () {},
            ),
            SizedBox(height: 20.h),
            Text("Didn't receive the OTP?"),
            GestureDetector(
              onTap: otpTimerController.remainingTime.value == 0
                  ? () {
                      otpTimerController.resendOtp();
                    }
                  : null, // Disable button while timer is running
              child: Text(
                'RESEND',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
