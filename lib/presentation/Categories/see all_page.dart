import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../home_screen/controller/home_controller.dart';
import '../home_screen/models/categories_model.dart';
import 'category_controller.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController categoryController = Get.put(HomeController());


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('See All',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: Obx(() {
      if (categoryController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (categoryController.categories.isEmpty) {
        return Center(child: Text("No categories found."));
      } else {
        return GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 40.0,
              mainAxisExtent: 180),
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];
            return Column(
              children: [
                Container(
                  height: 144.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green.shade800, width: 1),
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Image.network(
                            'https://grocery-dev.greendomains.in/storage/images/categories/${category
                                .image}',
                            fit: BoxFit.cover,
                            height: 100, // Image height
                            width: 100, // Image width
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.7.h),
                        child: Container(
                            height: 30,
                            width: 140.w,
                            decoration: BoxDecoration(
                                color: Colors.green.shade800,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(18))
                            ),
                            child: Center(child: Text(category.name,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white),))),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }
      } ),
    );
  }
}

