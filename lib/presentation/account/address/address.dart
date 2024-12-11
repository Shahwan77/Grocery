import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/widgets/button/button.dart';
import '../../Language Selection/language_controller.dart';
import 'address_controller.dart';



class AddressPage extends StatelessWidget {
  final AddressController controller = Get.put(AddressController());
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
            languagecontroller.addressText,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[100],
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languagecontroller.youraddressText,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: controller.addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on, color: Color(0xFFEB1C23)),
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Color(0xFFEB1C23),
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your full address here',
                ),
                style: TextStyle(fontSize: 14.sp),
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
                    if (controller.addressController.text.isNotEmpty) {
                      controller.postAddress();
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
