import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/OTP%20Field/otp_field.dart';
import 'package:grocery/presentation/account/change_password.dart';
import 'package:grocery/presentation/sign_up_screen/page/signup_page.dart';
import '../../../widgets/button/button.dart';
import '../../../widgets/textfield/custom_textfield.dart';
import '../../Language Selection/language_controller.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Text(
                  languagecontroller.LoginText,
                  style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Hey, Enter your account credentials to log in to your account.',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
                ),
                SizedBox(height: 40.h),
                Text(
                 languagecontroller.phonenoText,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                CustomTextfield(keytype: TextInputType.number,
                  controller: loginController.numberController,
                  isValid: loginController.isNumberValid.value, obsecuretext: false,
                  onchange: (value) {
                    loginController.validateEmail(value);
                  },
                  validator: (value)=>loginController.validateEmail(value!),
      
                  on_saveds: (value) {
                    loginController.numberController.text = value!;
                  },
                  fillclr: Colors.grey.shade200,
                  bdrds: 10.r,
                  preffix: Icon(Icons.mail_outline, color: Color(0xFFEB1C23)),
                  hint: languagecontroller.enternoText,
                ),
                SizedBox(height: 20.h),
                Text(
                  languagecontroller.passwordText,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                Obx(
                      () => CustomTextfield(
                    controller: loginController.passwordController,
                    valid: AutovalidateMode.onUserInteraction,
                    validator: (value)=>loginController.validatePassword(value!),
                    onchange: (value){
                      loginController.validatePassword(value);
                    },
                    isValid: loginController.isPasswordValid.value,
                    obsecuretext: loginController.obsecure.value,
      
                    fillclr: Colors.grey.shade200,
                    bdrds: 10.r,
                    preffix: Icon(Icons.lock_outlined, color: Color(0xFFEB1C23)),
                    hint: languagecontroller.enterpassText,
                    suffix: GestureDetector(
                      onTap: (){
                        loginController.obsecure.value =
                        ! loginController.obsecure.value;
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
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                     // Get.to(ChangePassword());
                    },
                    child: Text(
                      languagecontroller.forgotpassText,
                      style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Button(
                  color: Color(0xFFEB1C23),
                  size: Size(340.w, 45.h),
                  text: Text(
                   languagecontroller.LoginText,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                  ontap: () {
                    if (loginController.validateEmail(loginController.numberController.text) == null &&
                        loginController.validatePassword(loginController.passwordController.text) == null) {
                      loginController.login();
                    } else {
                      Get.snackbar('Error', 'Please enter valid credentials');
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
                    SizedBox(width: 5.w,),
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
                    style: TextStyle(fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}