import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/Admin/In_progress.dart';
import 'package:grocery/Admin/staff_controller.dart';

import '../presentation/Language Selection/language_controller.dart';
import '../widgets/button/button.dart';

class ToDo extends StatelessWidget {
   ToDo({super.key});
  final List<Map<String, dynamic>> orders = [
    {'id': '#7584639248', 'status': 'Left', 'name': 'Arshad MH'},
    // {'id': '#7584639249', 'status': 'Processing', 'name': 'John Doe'},
    // {'id': '#7584639250', 'status': 'Completed', 'name': 'Jane Smith'},
  ];
  @override
  Widget build(BuildContext context) {
    final StaffController staffController = Get.put(StaffController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            languagecontroller.unassignedText,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var item = orders[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.w),
                    tileColor: Color(0xFFEB1C23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.article, color: Colors.white),
                        Text(
                          item['id'],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.person, color: Colors.white, size: 20),
                        SizedBox(width: 8.w),
                        Text(
                          item['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.grey.shade100,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.r)),
                          ),
                          builder: (BuildContext context) {
                            return Directionality(
                              textDirection: TextDirection.ltr,
                              child: Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.article,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              item['id'],
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 70.w,
                                          height: 26.h,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFC107),
                                            borderRadius:
                                            BorderRadius.circular(8.r),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.logout_outlined,
                                                  size: 16,
                                                  color: Colors.white),
                                              SizedBox(width: 4.w),
                                              Text(
                                                item['status'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Icon(Icons.person, color: Colors.grey),
                                        SizedBox(width: 8.w),
                                        Text(
                                          item['name'],
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      'Select Staff:',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10.h),
                                    Wrap(
                                      spacing: 10.w,
                                      runSpacing: 10.h,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            staffController.selectedStaff.value = 'STAFF NO.1';
                                          },
                                          child: Container(
                                              height: 24.h,
                                              width: 70.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: Center(
                                                  child: Text(
                                                    'STAFF NO.1',
                                                    style: TextStyle(fontSize: 10.sp),
                                                  ))),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            staffController.selectedStaff.value = 'STAFF NO.2';
                                          },
                                          child: Container(
                                              height: 24.h,
                                              width: 70.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: Center(
                                                  child: Text(
                                                    'STAFF NO.2',
                                                    style: TextStyle(fontSize: 10.sp),
                                                  ))),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            staffController.selectedStaff.value = 'STAFF NO.3';
                                          },
                                          child: Container(
                                              height: 24.h,
                                              width: 70.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: Center(
                                                  child: Text(
                                                    'STAFF NO.3',
                                                    style: TextStyle(fontSize: 10.sp),
                                                  ))),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            staffController.selectedStaff.value = 'STAFF NO.4';
                                          },
                                          child: Container(
                                              height: 24.h,
                                              width: 70.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: Center(
                                                  child: Text(
                                                    'STAFF NO.4',
                                                    style: TextStyle(fontSize: 10.sp),
                                                  ))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Center(
                                        child: Button(
                                          size: Size(320.w, 38.h),
                                          color: Colors.green,
                                          text: Text('CONFIRM',style: TextStyle(color: Colors.white),),
                                          ontap: () {
                                            Navigator.pop(context);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child:Container(
                          width: 70.w,
                          height: 26.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_outlined, size: 16, color: Colors.white),
                              SizedBox(width: 4.w),
                              Text(
                                item['status'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
