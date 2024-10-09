import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/OTP%20Field/otp_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:grocery/widgets/Drop/drop.dart';
import '../../../widgets/button/button.dart';
import '../../../widgets/textfield/custom_textfield.dart';
import '../../sign_in_screen/page/login_page.dart';
import '../controller/signup_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
              height: 22.h,
              width: 26.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
              child: Center(
                  child: Icon(Icons.arrow_back_ios_rounded,
                      color: Color(0xFFEB1C23), size: 20.sp))),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Personal Details',
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor:Color(0xFFEB1C23),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              CustomTextfield(
                controller: signupController.nameController,
                fillclr: Colors.grey.shade200,
                bdrds: 10.r,
                preffix: Icon(Icons.person_outline_sharp, color: Color(0xFFEB1C23)),
                hint: 'Name',
              ),
              SizedBox(height: 24.h),
              IntlPhoneField(
                controller: signupController.mobileNoController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  signupController.selectedCountryCode.value = phone.countryCode; // Store the country code
                },
              ),

              SizedBox(height: 8.h),
              CustomTextfield(
                fillclr: Colors.grey.shade200,
                bdrds: 10.r,
                preffix: Icon(Icons.mail_outline, color: Color(0xFFEB1C23)),
                hint: 'Enter your email address',
              ),
              SizedBox(height: 24.h),
              Obx(
                    () => CustomTextfield(
                  controller: signupController.passwordController,
                  fillclr: Colors.grey.shade200,
                  bdrds: 10.r,
                  preffix: Icon(Icons.lock_outlined, color: Color(0xFFEB1C23)),
                  hint: 'Enter your password',
                  obsecuretext: signupController.obsecure.value,
                  suffix: GestureDetector(
                    onTap: signupController.togglePasswordVisibility,
                    child: Icon(
                      signupController.obsecure.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(0xFFEB1C23),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Obx(
                    () => CustomTextfield(
                  controller: signupController.passwordConfirmController,
                  fillclr: Colors.grey.shade200,
                  bdrds: 10.r,
                  preffix: Icon(Icons.lock_outlined, color: Color(0xFFEB1C23)),
                  hint: 'Confirm your password',
                  obsecuretext: signupController.obsecureConfirm.value,
                  suffix: GestureDetector(
                    onTap: signupController.toggleConfirmPasswordVisibility,
                    child:  Icon(
                      signupController.obsecureConfirm.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(0xFFEB1C23),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Obx(
                        () => Container(
                      height: 35.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Checkbox(
                        value: signupController.isChecked.value,
                        onChanged: signupController.toggleCheckbox,
                        activeColor: Colors.transparent,
                        checkColor: Color(0xFFEB1C23),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  RichText(
                    text: TextSpan(
                      text: 'I agree to ',
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () {
                              print('Terms of Use tapped');
                            },
                            child: Text(
                              'Terms of Use',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue.shade800,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () {
                              print('Privacy Policy tapped');
                            },
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue.shade800,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: ' of this\napp',
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Obx(() => Button(
                color: Color(0xFFEB1C23),
                size: Size(340.w, 45.h),
                text: signupController.isLoading.value
                    ? CircularProgressIndicator()
                    : Text(
                  "Register",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
                ontap: signupController.isLoading.value
                    ? null
                    : () {
                  // Print message when the button is clicked
                  print("Register button clicked, starting OTP verification.");

                  // Call startOtpVerification instead of registerUser directly
                  signupController.startOtpVerification();
                },
              )),
              // SizedBox(height: 10.h),
              // Obx(() {
              //   if (signupController.showOtpField.value) {
              //     return CustomTextfield(
              //       hint: 'Enter OTP',
              //       fillclr: Colors.grey.shade200,
              //       bdrds: 10.r,
              //     );
              //   } else {
              //     return Container();
              //   }
              // }),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginPage());
                    },
                    child: Text('Login here',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
