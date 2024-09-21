import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Categories/see%20all_page.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/apiClient/api.dart';
import '../home_screen/controller/home_controller.dart';
import '../organic/organic_page.dart';
import 'categories_detail.dart';
import 'category_controller.dart';

class CategoriesPage extends StatelessWidget {
  final HomeController categoryController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              GestureDetector(
                child: Text(
                  "See all",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: Colors.green.shade800,
                  ),
                ),
                onTap: () {

                  Get.to(SeeAllPage());
                },
              ),
            ],
          ),
        ),
        Obx(() {
          if (categoryController.isLoading.value) {
            return GridView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 0.7,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  period: Duration(seconds: 60),
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
          } else if (categoryController.categories.isEmpty) {
            return Center(child: Text("No categories found."));
          } else {
            return GridView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
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
                final category = categoryController.categories[index];
                return GestureDetector(
                  onTap: () {

                    if (category.id == 2) {

                      Get.to(() => OrganicPage());
                    } else {

                      Get.to(() => DetailPage(categoryId: category.id.toString(), categoryName: category.name,));
                    }
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black26,
                            //     blurRadius: 4.0,
                            //     offset: Offset(0, 2),
                            //   ),
                            // ],
                            // borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${Api.ImageUrl}/categories/${category.image}',
                              ),
                              fit: BoxFit.contain,
                              //alignment: Alignment(2, 2)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ],
    );
  }
}
