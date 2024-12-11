import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/account/change_email/change_email_controller.dart';
import 'package:grocery/widgets/button/button.dart';

import '../../../../widgets/textfield/custom_textfield.dart';
import '../../Language Selection/language_controller.dart';
import 'edit_profile_controller.dart';



class EditProfile extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());
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
            languagecontroller.profileText,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 14.w,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: CircleAvatar(
              //     radius: 50.r,
              //     backgroundColor: Colors.grey.shade200,
              //     child: Icon(
              //       Icons.person,
              //       size: 60.sp,
              //       color: Color(0xFFEB1C23),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.h),
              Text(
               languagecontroller.yournameText,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextfield(
                bdrds: 10.r,
                fillclr: Colors.grey.shade200,
                hint: "Name",
                controller: controller.nameController,
                preffix: Icon(Icons.person, color: Color(0xFFEB1C23)),
              ),
              SizedBox(height: 24.h),
              Obx(() => controller.isLoading.value
                  ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFEB1C23),
                ),
              )
                  : SizedBox(
                width: double.infinity,
                height: 40.h,
                child: Button(
                  color: Color(0xFFEB1C23),
                  text: Text(
                    languagecontroller.submitText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ontap: () {
                    if (controller.nameController.text.isNotEmpty) {
                      controller.postEmail();
                    } else {
                      // Get.snackbar(
                      //   'Error',
                      //   'Please enter an address',
                      //   snackPosition: SnackPosition.BOTTOM,
                      //   backgroundColor: Colors.red[400],
                      //   colorText: Colors.white,
                      // );
                    }
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
