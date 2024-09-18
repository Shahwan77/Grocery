import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Categories/see%20all_page.dart';
import 'package:shimmer/shimmer.dart';
import 'categories_detail.dart';
import 'category_controller.dart';



class CategoriesPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
                  // Navigate to the "See All" page
                  Get.to(SeeAllPage());
                },
              ),
            ],
          ),
        ),
        Obx(() {
          if (categoryController.isLoading.value) {
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 0.7,
              ),
              itemCount: 6, // Placeholder item count for shimmer
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
                            color: Colors.white, // Placeholder color
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        height: 10.h,
                        width: 60.w,
                        color: Colors.white, // Placeholder color for text
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
              padding: EdgeInsets.all(8.0),
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
                    Get.to(() => DetailPage(categoryId: category.id.toString()));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://grocery-dev.greendomains.in/storage/images/categories/${category.image}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        category.name,
                        style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                        ),
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
