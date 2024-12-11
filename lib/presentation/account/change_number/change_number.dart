import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/presentation/account/change_number/change_number_controller.dart';
import 'package:grocery/widgets/button/button.dart';
import 'package:grocery/widgets/textfield/custom_textfield.dart';

import '../../Language Selection/language_controller.dart';

class ChangeNumber extends StatelessWidget {
  final ChangeNumberController controller = Get.put(ChangeNumberController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextfield(
              bdrds: 10.r,
              keytype: TextInputType.numberWithOptions(),
              fillclr: Colors.grey.shade200,
              hint: "Phone No",
              controller: controller.mobileNoController,
            ),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : Button(
              color:Color(0xFFEB1C23),
              size: Size(double.infinity, 40.h),
              text: Text("Reset Number",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
              ontap:  () {
                controller.changeNumber(
                );
              },
            )
            ),
          ],
        ),
      ),
    );
  }
}
