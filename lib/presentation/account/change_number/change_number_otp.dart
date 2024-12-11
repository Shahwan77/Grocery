import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery/presentation/account/change_number/change_number_otp_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../widgets/button/button.dart';
import '../../../widgets/textfield/custom_textfield.dart';
import '../../Language Selection/language_controller.dart';

class ChangeNumberOtp extends StatelessWidget {
  const ChangeNumberOtp({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeNumberOtpController numberController = Get.put(ChangeNumberOtpController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
                height: 22.h,
                width: 26.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFFEB1C23),
                      size: 20.sp,
                    ))),
            onPressed: () {
              Get.back();
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFFEB1C23),
          title: Text(
            languagecontroller.changenumberText,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languagecontroller.yournumberText,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                languagecontroller.sendanotpText,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.h),
              // IntlPhoneField(
              //   controller: numberController.mobileNoController,
              //   decoration: InputDecoration(
              //     contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              //     fillColor: Colors.grey.shade200,
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.r),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              //   initialCountryCode: 'IN',
              //   onChanged: (phone) {
              //     numberController.selectedCountryCode.value = phone.countryCode;
              //   },
              // ),

              CustomTextfield(
                controller: numberController.mobileNoController,
                fillclr: Colors.grey.shade200,
                bdrds: 10.r,
                preffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Image.asset('assets/uae.png',width: 20.w,),
                      Icon(Icons.phone, color: Color(0xFFEB1C23)),
                      Text(
                        '+971 ',  // Static UAE country code
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // hint: 'Enter your phone number',
                keytype: TextInputType.phone,
                onchange: (value) {
                  numberController.selectedCountryCode.value = '+971'; // Store the UAE country code
                },
              ),
              SizedBox(height: 20.h),
              // Send OTP Button
              SizedBox(
                width: double.infinity,
                child: Button(
                  size: Size(double.infinity, 40.h),
                  text: Text(languagecontroller.sendotpText, style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  color: Color(0xFFEB1C23),
                  ontap: () {
                    numberController.startOtpVerification();
                  },
                ),
              ),
              SizedBox(height: 20.h),

              // Show OTP field and verify button if OTP is sent
              Obx(() {
                if (numberController.isOtpVisible.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // OTP input field
                      Text(
                        languagecontroller.yourotpText,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        controller: numberController.otpController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20.h),

                      // Verify OTP Button
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          size: Size(double.infinity, 40.h),
                          text: Text(languagecontroller.verifyotpText, style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                          color: Color(0xFFEB1C23),
                          ontap: () {
                            numberController.verifyOtpAndResetPassword();
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Container(); // Return an empty container when OTP is not visible
              }),
            ],
          ),
        ),
      ),
    );
  }
}
