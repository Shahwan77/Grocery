import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/widgets/Drop/drop.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Personal Details',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              CustomTextfield(
                fillclr: Colors.grey.shade200,
                bdrds: 10,
                preffix: Icon(Icons.person_outline_sharp, color: Colors.green),
                hint: 'Name',
              ),
              SizedBox(height: 24.h),
              Drop(),
              SizedBox(height: 24.h),
              CustomTextfield(
                fillclr: Colors.grey.shade200,
                bdrds: 10,
                preffix: Icon(Icons.mail_outline, color: Colors.green),
                hint: 'Enter your email address',
              ),
              SizedBox(height: 24.h,),
              Obx(
                () => CustomTextfield(
                  controller: signupController.passwordController,
                  fillclr: Colors.grey.shade200,
                  bdrds: 10,
                  preffix: Icon(Icons.lock_outlined, color: Colors.green),
                  hint: 'Enter your password',
                  obsecuretext: signupController.obsecure.value,
                  suffix: GestureDetector(
                    onTap: () {
                      signupController.togglePasswordVisibility();
                    },
                    child: Icon(
                      signupController.obsecure.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h,),
              Obx(
                    () => CustomTextfield(
                  controller: signupController.passwordController,
                  fillclr: Colors.grey.shade200,
                  bdrds: 10,
                  preffix: Icon(Icons.lock_outlined, color: Colors.green),
                  hint: 'Enter your password',
                  obsecuretext: signupController.obsecure.value,
                  suffix: GestureDetector(
                    onTap: () {
                      signupController.togglePasswordVisibility();
                    },
                    child: Icon(
                      signupController.obsecure.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                initialCountryCode: 'IN',
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextfield(
                fillclr: Colors.grey.shade200,
                bdrds: 10,
                preffix: Icon(Icons.mail_outline, color: Colors.green),
                hint: 'Nationality',
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Obx(() => Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Checkbox(
                      value: signupController.isChecked.value,
                      onChanged: signupController.toggleCheckbox,
                      activeColor: Colors.transparent,
                      checkColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide.none,
                      ),
                    )
                  )),
                  SizedBox(
                    width: 5.w,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'I agree to ',
                        style: TextStyle(color: Colors.grey,fontSize: 14)),
                    TextSpan(
                        text: 'Terms of Use ',
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    TextSpan(text: 'and ', style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: 'Privacy Policy ',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue.shade800,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: 'of this\napp',
                        style: TextStyle(color: Colors.grey,fontSize: 14)),
                  ]))
                ],
              ),
              SizedBox(height: 10.h,),
              Button(
                color: Colors.green.shade800,
                size: Size(340.w, 45.h),
                text: Text(
                  "Register",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
                ontap: () {

                },
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 5.w,),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginPage());
                    },
                    child: Text(
                      'Login here',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h,)
            ],
          ),
        ),
      ),
    );
  }
}
