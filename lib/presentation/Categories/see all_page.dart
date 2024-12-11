import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/apiClient/api.dart';
import '../Language Selection/language_controller.dart';
import '../home_screen/controller/home_controller.dart';
import '../home_screen/models/categories_model.dart';
import 'categories_detail.dart';
import 'category_controller.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController categoryController = Get.put(HomeController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading:  IconButton(
            icon: Container(
                height: 22.h,width: 26.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r)
                ),
                child: Center(child: Icon(Icons.arrow_back_ios_rounded,color: Color(0xFFEB1C23),size: 20.sp,))),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Color(0xFFEB1C23),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            languagecontroller.seeallText,
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
                  mainAxisExtent: ScreenUtil().screenWidth >600?280:180
              ),
              itemCount: categoryController.categories.length,
              itemBuilder: (context, index) {
                final category = categoryController.categories[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailPage(categoryId: category.id.toString(), categoryName: category.name,));

                  },
                  child: Column(
                    children: [
                      Container(
                        height: 144.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Color(0xFFEB1C23), width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child:category.image != null && category.image!.isNotEmpty
                                    ?Image.network(
                                  '${Api.ImageUrl}/categories/${category.image}',
                                  fit: BoxFit.cover,
                                  height: 100, // Image height
                                  width: 100, // Image width
                                  errorBuilder: (context, error, stackTrace) => Icon(
                                    Icons.hide_image_outlined,
                                    size: 94.sp,
                                    color: Colors.grey,
                                  ),
                                )
                                    : Icon(
                                  Icons.hide_image_outlined,
                                  size: 90.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: ScreenUtil().screenWidth > 600 ? 53.h : 24.7.h,
                              ),
                              child: Container(
                                  height: 24.2.h,
                                  width: 140.w,
                                  decoration: BoxDecoration(
                                      color:Color(0xFFEB1C23),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(18))),
                                  child: Center(
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 6.w),
                                        child: Text(
                                          category.name,
                                          style: TextStyle(
                                              fontSize: 10.sp, color: Colors.white),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                  )
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}