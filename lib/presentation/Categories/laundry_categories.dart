import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Categories/see%20all_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/apiClient/api.dart';
import '../Language Selection/language_controller.dart';
import '../home_screen/controller/home_controller.dart';
import 'categories_detail.dart';

class LaundryCategories extends StatelessWidget {
  final HomeController categoryController = Get.put(HomeController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languagecontroller.categoriesText,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              GestureDetector(
                child: Text(
                  languagecontroller.seeallText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: Color(0xFFEB1C23),
                  ),
                ),
                onTap: () {
                  Get.to(SeeAllPage());
                },
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: categoryController.fetchLaundry(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 0.7,
                ),
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          height: 10.h,
                          width: 60.w,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading categories."));
            } else if (categoryController.categories.isEmpty || categoryController.categories.every((category) => category.type != 'laundry')) {
              return Center(child: Text("No laundry items found"));
            }  else {
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.7,
                  mainAxisExtent: 120,
                ),
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailPage(
                        categoryId: category.id.toString(),
                        categoryName: category.name,
                      ));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                '${Api.ImageUrl}/categories/${category.image}',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}