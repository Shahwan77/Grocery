import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/OTP%20Field/otp_field.dart';
import 'package:grocery/presentation/sign_up_screen/page/signup_page.dart';
import '../../../widgets/button/button.dart';
import '../../../widgets/textfield/custom_textfield.dart';
import '../Language Selection/language_controller.dart';
import '../sign_in_screen/controller/login_controller.dart';

class AccountLoginPage extends StatelessWidget {
  const AccountLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Image.asset(
              'assets/logo.png',
              width: 160.w,
              height: 120.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  languagecontroller.GroceryText,
                  style:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                Text(
                 languagecontroller.servicesText,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.red),
                ),
              ],
            ),
            Text(languagecontroller.wemakeText),
            SizedBox(height: 20.h),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 2.h),
              child: Container(
                  height: 460.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.r),
                          topRight: Radius.circular(50.r))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          languagecontroller.loginText,
                          style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),
                        ),
                        Text(
                          languagecontroller.loginsubText,
                          style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Text(
                         languagecontroller.armangroceryText,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomTextfield(
                          keytype: TextInputType.number,
                          controller: loginController.numberController,
                          isValid: loginController.isNumberValid.value,
                          obsecuretext: false,
                          onchange: (value) {
                            loginController.validateEmail(value);
                          },
                          validator: (value) =>
                              loginController.validateEmail(value!),
                          on_saveds: (value) {
                            loginController.numberController.text = value!;
                          },
                          fillclr: Colors.white,
                          bdrds: 10.r,
                          preffix: Icon(Icons.mail_outline,
                              color: Color(0xFFEB1C23)),
                          hint: languagecontroller.enternoText,
                        ),
                        SizedBox(height: 8.h),
                        Obx(
                              () => CustomTextfield(
                            controller: loginController.passwordController,
                            valid: AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                loginController.validatePassword(value!),
                            onchange: (value) {
                              loginController.validatePassword(value);
                            },
                            isValid: loginController.isPasswordValid.value,
                            obsecuretext: loginController.obsecure.value,
                            fillclr: Colors.white,
                            bdrds: 10.r,
                            preffix: Icon(Icons.lock_outlined,
                                color: Color(0xFFEB1C23)),
                            hint: languagecontroller.enterpassText,
                            suffix: GestureDetector(
                              onTap: () {
                                loginController.obsecure.value =
                                !loginController.obsecure.value;
                              },
                              child: Icon(
                                loginController.obsecure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(() {
                                  return GestureDetector(
                                    onTap: loginController.toggleSelection, // Call toggleSelection on tap
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: 30.w,
                                      height: 14.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: loginController.isSelected.value ? Colors.green : Colors.grey.shade200,
                                        border: Border.all(color: Colors.grey.shade500),
                                      ),
                                      child: Align(
                                        alignment: loginController.isSelected.value ? Alignment.centerRight : Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: AnimatedContainer(
                                            duration: Duration(milliseconds: 300),
                                            width: 11.w,
                                            height: 10.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                SizedBox(width: 8.w,),
                                Text(languagecontroller.rememberText,style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                            GestureDetector(
                              child: Text(
                                languagecontroller.forgotpassText,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14.sp,color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Button(
                          color: Color(0xFFEB1C23),
                          size: Size(340.w, 45.h),
                          text: Text(
                            languagecontroller.LoginText,
                            style:
                            TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                          ontap: () {
                            if (loginController.validateEmail(loginController
                                .numberController.text) ==
                                null &&
                                loginController.validatePassword(loginController
                                    .passwordController.text) ==
                                    null) {
                              loginController.login();
                            } else {
                              Get.snackbar(
                                  'Error', 'Please enter valid credentials');
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              languagecontroller.dontaccText,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(SignupPage());
                              },
                              child: Text(
                                languagecontroller.createhereText,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            languagecontroller.skipinText,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
