import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/button/button.dart';
import '../widgets/textfield/custom_textfield.dart';
import 'More.dart';
import 'date.dart';

class New_offer extends StatelessWidget {
  const New_offer({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signupController = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: Color(0xFF3a80a4),
      appBar: AppBar(
        backgroundColor: Color(0xFF3a80a4),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.sp,
          ),
          onPressed: () {},
        ),
        title: Text(
          'New Offer',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 50.h,
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 860.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28.r),
            topLeft: Radius.circular(28.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 45.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  children: [
                    // Dropdown for Category
                    GetBuilder<SignUpController>(
                      builder: (controller) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x803a80a4),
                                    offset: Offset(0, 2),
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 16.0,
                                  ),
                                ),
                                items: controller.categories
                                    .map((String category) {
                                  return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.setSelectedCategory(value!);
                                },
                              ),
                            ),
                            Positioned(
                              top: -12,
                              left: 16,
                              child: Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Dropdown for Type
                    GetBuilder<SignUpController>(
                      builder: (controller) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x803a80a4),
                                    offset: Offset(0, 2),
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 16.0,
                                  ),
                                ),
                                items: controller.types.map((String type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.setSelectedType(value!);
                                },
                              ),
                            ),
                            Positioned(
                              top: -12,
                              left: 16,
                              child: Text(
                                'Type',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 16.h),

                    // Other Text Fields
                    CustTextField(
                      labelText: 'Header',
                      borderRadius: 14.0,
                      fillColor: Colors.white,
                      boxColor: Color(0x803a80a4),
                      maxLines: 1,
                    ),
                    SizedBox(height: 16.h),
                    CustTextField(
                      labelText: 'Sub Header',
                      borderRadius: 14.0,
                      fillColor: Colors.white,
                      boxColor: Color(0x803a80a4),
                      maxLines: 1,
                    ),
                    SizedBox(height: 16.h),
                    CustTextField(
                      labelText: 'Summary',
                      borderRadius: 14.0,
                      fillColor: Colors.white,
                      boxColor: Color(0x803a80a4),
                      height: 200,
                      maxLines: null,
                      minLines: 50,
                    ),
                    SizedBox(height: 16.h),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 46.h,
                          width: 340.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x803a80a4),
                                offset: Offset(0, 2),
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Drop your image here, or ',
                                    style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                    ),
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: GestureDetector(
                                          onTap: () {
                                            print('Browse tapped');
                                          },
                                          child: Text(
                                            'browse',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Supports: JPG, JPEG2000, PNG',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -12,
                          left: 16,
                          child: Text(
                            'Offer Image',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Obx(() => Container(
                          height: 26.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Checkbox(
                            value: signupController.isChecked.value,
                            onChanged: (bool? value) {
                              signupController.isChecked.value = value ?? false;
                            },
                            activeColor: Colors.transparent,
                            checkColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide.none,
                            ),
                          ),
                        )),
                        SizedBox(
                          width: 5.w,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Offer Visibility',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: ' (offer duration and offer visibility time period)',
                                style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Obx(() => DatePickerStack(
                      isCheckboxChecked: signupController.isChecked.value,
                    )
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 34.h,width: 60.w,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16.r)
                          ),
                          child: Icon(Icons.close_outlined,color: Colors.white,size:38.sp,),
                        ),
                        Container(
                          height: 34.h,width: 60.w,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16.r)
                          ),
                          child: Icon(Icons.check,color: Colors.white,size:38.sp,),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 60.h)
            ],
          ),
        ),
      ),
    );
  }
}