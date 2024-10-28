import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/Admin/In_progress.dart';
import 'package:grocery/Admin/To_do.dart';
import 'package:grocery/Admin/staff_controller.dart';
import 'package:grocery/widgets/app_bar/appbar.dart';
import 'package:grocery/widgets/button/button.dart';

import '../presentation/Language Selection/language_controller.dart';

class OrdersList extends StatelessWidget {
  OrdersList({super.key});

  final List<Map<String, dynamic>> orders = [
    {'id': '#7584639248', 'status': 'Left', 'name': 'Arshad MH'},
  ];

  @override
  Widget build(BuildContext context) {
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    final StaffController staffController = Get.put(StaffController());

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(),
          body: Column(
            children: [
              AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  'Orders list',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.headset_mic, color: Colors.white),
                        SizedBox(width: 18.w),
                        GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.person_3_rounded,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ],
                backgroundColor: Color(0xFFEB1C23),
              ),
              TabBar(
                labelColor: Color(0xFFEB1C23),
                unselectedLabelColor: Colors.grey,dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.assignment,
                    ),
                    text: languagecontroller.todoText,
                  ),
                  Tab(
                    icon: Icon(
                      Icons.assignment_late,
                    ),
                    text: languagecontroller.inprogressText,
                  ),
                  Tab(
                    icon: Icon(Icons.assignment_turned_in),
                    text: languagecontroller.completeText,
                  ),

                ],
              ),
              // TabBarView with content for each tab
              Expanded(
                child: TabBarView(
                  children: [
                    ToDo(),
                    // In Progress Tab Content
                    InProgress(),
                    // Completed Tab Content
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Text('Completed Orders List'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
