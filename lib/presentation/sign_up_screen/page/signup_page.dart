import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/OTP%20Field/otp_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:grocery/widgets/Drop/drop.dart';
import '../../../widgets/button/button.dart';
import '../../../widgets/textfield/custom_textfield.dart';
import '../../Language Selection/language_controller.dart';
import '../../sign_in_screen/page/login_page.dart';
import '../controller/signup_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());
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
            languagecontroller.personaldetailsText,
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
                  hint: languagecontroller.nameText,
                ),
                SizedBox(height: 24.h),
                TextField(
                  controller: signupController.addressController,
                  maxLines: 4,
                  minLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on, color: Color(0xFFEB1C23)),
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:BorderSide(style: BorderStyle.solid),
                    ),
                    hintText: 'Enter your full address here',
                  ),
                  style: TextStyle(fontSize: 14.sp),
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


                // CustomTextfield(
                //   controller: signupController.mobileNoController,
                //   fillclr: Colors.grey.shade200,
                //   bdrds: 10.r,
                //   preffix: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         //Image.asset('assets/uae.png',width: 20.w,),
                //         Icon(Icons.phone, color: Color(0xFFEB1C23)),
                //         Text(
                //           '+971 ',  // Static UAE country code
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //   ),
                //  // hint: 'Enter your phone number',
                //   keytype: TextInputType.phone,
                //   onchange: (value) {
                //     signupController.selectedCountryCode.value = '+971'; // Store the UAE country code
                //   },
                // ),

                SizedBox(height: 24.h),
                CustomTextfield(
                  controller: signupController.emailController,
                  fillclr: Colors.grey.shade200,
                  bdrds: 10.r,
                  preffix: Icon(Icons.mail_outline, color: Color(0xFFEB1C23)),
                  hint: languagecontroller.youremailText,
                ),
                SizedBox(height: 24.h),
                Obx(
                      () => CustomTextfield(
                    controller: signupController.passwordController,
                    fillclr: Colors.grey.shade200,
                    bdrds: 10.r,
                    preffix: Icon(Icons.lock_outlined, color: Color(0xFFEB1C23)),
                    hint: languagecontroller.enterpassText,
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
                    hint: languagecontroller.confirmpassword,
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
                        text: languagecontroller.agreetoText,
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                print('Terms of Use tapped');
                              },
                              child: Text(
                                languagecontroller.termsuseText,
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
                            text: languagecontroller.andText,
                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                print('Privacy Policy tapped');
                              },
                              child: Text(
                                languagecontroller.privacypolicyText,
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
                            text: languagecontroller.thisappText,
                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
              Obx(
                    () => Button(
                  color: Color(0xFFEB1C23),
                  size: Size(340.w, 45.h),
                  text: signupController.isLoading.value
                      ? CircularProgressIndicator()
                      : Text(
                    languagecontroller.registerText,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                  ontap: signupController.isLoading.value
                      ? null
                      : () async {
                    // Print message for debugging
                    print("Register button clicked, validating mobile number.");

                    // Validate the mobile number
                    await signupController.validateMobile();

                    // Check if validation succeeded
                    if (signupController.isRegistrationSuccessful.value) {
                      print("Mobile number validated. Proceeding to OTP verification.");
                      signupController.startOtpVerification();
                    } else {
                      print("Mobile number validation failed. Staying on the current page.");
                    }
                  },
                ),
              ),

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
                    Text(languagecontroller.haveaccountText,
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginPage());
                      },
                      child: Text(languagecontroller.loginhereText,
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}