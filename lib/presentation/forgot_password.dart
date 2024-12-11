import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/widgets/button/button.dart';
import 'package:grocery/widgets/textfield/custom_textfield.dart';

import 'Language Selection/language_controller.dart';
import 'forgot_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  final ResetPasswordController controller = Get.put(ResetPasswordController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
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
            languagecontroller.resetpassword,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languagecontroller.newpasswordText,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextfield(
                  bdrds: 10.r,
                keytype: TextInputType.numberWithOptions(),
                fillclr: Colors.grey.shade200,
                hint: languagecontroller.newpasswordText,
                controller: controller.newPasswordController,
              ),
              // TextField(
              //   controller: passwordController,
              //   decoration: InputDecoration(labelText: 'New Password'),
              //   obscureText: true,
              //
              // ),
              SizedBox(height: 20.h,),
              Text(
                languagecontroller.confirmpassword,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextfield(
                bdrds: 10.r,
                keytype: TextInputType.numberWithOptions(),
                fillclr: Colors.grey.shade200,
                hint: languagecontroller.confirmpassword,
                controller: controller.confirmPasswordController,
              ),
              // TextField(
              //   controller: confirmPasswordController,
              //   decoration: InputDecoration(labelText: 'Confirm Password'),
              //   obscureText: true,
              // ),
              SizedBox(height: 20),
              Center(
                child: Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Button(
                  color:Color(0xFFEB1C23),
                    size: Size(double.infinity, 40.h),
                    text: Text(languagecontroller.resetpassword,style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                    ontap:  () {
                      controller.resetPassword(
                      );
                    },
                )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
