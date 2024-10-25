import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/Admin/staff_controller.dart';

import '../presentation/Language Selection/language_controller.dart';
import '../widgets/button/button.dart';
import 'ordered_products.dart';

class InProgress extends StatelessWidget {
  InProgress({super.key});
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
                    trailing: Obx(
                          () => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person_pin_rounded, size: 16, color: Colors.white),
                              SizedBox(width: 4.w),
                              Text(
                                staffController.selectedStaff.value.isNotEmpty
                                    ? staffController.selectedStaff.value
                                    : item['status'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: () {
                                  Get.to(OrderedProducts());
                                },
                                child: Container(
                                    height: 16.h,width: 19.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30.r)
                                    ),
                                    child: Center(child: Icon(Icons.arrow_forward_ios_rounded,color:Color(0xFFEB1C23),size: 16.sp,))),
                              ),
                            ],
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
