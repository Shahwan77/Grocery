import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Categories/categories_page.dart';
import 'package:grocery/presentation/Most%20Popular/most_popular_page.dart';
import 'package:grocery/presentation/Popular%20Products/popular_product_page.dart';
import 'package:grocery/presentation/Top%20Discount%20Products/top_discount_page.dart';
import 'package:grocery/widgets/carousel/cus_carousel.dart';
import '../../../widgets/app_bar/appbar.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(toolbarHeight: 120.h),
      body: ListView(
        children: [
          SizedBox(height: 10.h),
          CusCarousel(),
          SizedBox(height: 10.h),
          CategoriesPage(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(right: 40.w),
                  child: Text(
                    'ORDER YOUR CUSTOMIZED CAKE !!!',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w),
                  child: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.green,
                      image: DecorationImage(
                        image: AssetImage('assets/gro4.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          MostPopularPage(),
         PopularProductPage(),
          TopDiscountPage(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
