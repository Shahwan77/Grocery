import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/widgets/button/button.dart';
import 'package:pinput/pinput.dart';

import '../sign_up_screen/controller/signup_controller.dart';

class OtpField extends StatelessWidget {
   OtpField({super.key});
   final SignupController signupController = Get.put(SignupController());


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 320.h,
          width: 300.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 250.w, top: 10.h),
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 24.sp, // Adjust the size if needed
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 180.h),
                child: Text(
                  'Enter OTP:',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Pinput(
                keyboardType: TextInputType.number,
                length: 4,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 38.w),
                child: Row(
                  children: [
                    Text(
                      "Didn't get OTP code?",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text('Resend code',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              SizedBox(height: 80.h,),
              Button(
                size: Size(126.w, 40.h),
                color: Colors.green.shade800,
                text: Text(
                  'Submit OTP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800),
                ),
                ontap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
void showAmountDialog(BuildContext context, Function(String) onSubmit) {
  TextEditingController amountController = TextEditingController();
  final SignupController signupController = Get.put(SignupController());


  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 320.h,
        width: 300.w,
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 210.w,),
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 28.sp, // Adjust the size if needed
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 160.h),
              child: Text(
                'Enter OTP:',
                style:
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Pinput(
              keyboardType: TextInputType.number,
              length: 4,
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  Text(
                    "Didn't get OTP code?",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text('Resend code',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            SizedBox(height: 80.h,),
            Button(
              size: Size(126.w, 40.h),
              color: Colors.green.shade800,
              text: Text(
                'Submit OTP',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800),
              ),
              ontap: () {},
            )
          ],
        ),
      ),
    );

  },);
}
