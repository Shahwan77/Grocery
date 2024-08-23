import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Categories/see%20all_page.dart';

import 'categories_detail.dart';
import '../home_screen/models/categories_model.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

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
                style: GoogleFonts.roboto(
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
        GridView.builder(
          padding: EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.7,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => DetailPage(item: item));
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(item.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    item.name,
                    style: GoogleFonts.roboto(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
