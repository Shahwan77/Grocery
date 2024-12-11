import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Language Selection/language_controller.dart';
import 'change_password_controller.dart';
import 'package:grocery/widgets/button/button.dart';
import 'package:grocery/widgets/textfield/custom_textfield.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX controller instance
    final ChangePasswordController controller = Get.put(ChangePasswordController());
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
            languagecontroller.changePasswordText,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languagecontroller.createnewpasswordText,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp),
              ),
              Text(
                  languagecontroller.yournewpasswordText),
              SizedBox(
                height: 10.h,
              ),
              Text(
                languagecontroller.currentpasswordText,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextfield(
                controller: controller.currentPasswordController,
                bdrds: 10.r,
                fillclr: Colors.grey.shade100,
                obsecuretext: false,
                validator: (value)=>controller.validateCurrentPassword(value!),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                languagecontroller.newpasswordText,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextfield(
                controller: controller.newPasswordController,
                bdrds: 10.r,
                fillclr: Colors.grey.shade100,
                obsecuretext: false,
                validator: (value)=>controller.validateNewPassword(value!),
              ),
              Text(
                'Must be at least 8 characters',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                languagecontroller.confirmpassword,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextfield(
                controller: controller.confirmPasswordController,
                bdrds: 10.r,
                fillclr: Colors.grey.shade100,
                obsecuretext: false,
                validator:(value)=>controller.validateConfirmPassword(value!),
              ),
              Text(
                'Both passwords must match',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 24.h,
              ),
              Obx(() {
                if (controller.isPasswordChangeInProgress.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return Button(
                  text: Text(languagecontroller.resetpassword, style: TextStyle(color: Colors.white)),
                  color: Color(0xFFEB1C23),
                  size: Size(340.w, 42.h),
                  ontap: controller.changePassword,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
