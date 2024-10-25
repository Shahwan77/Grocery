import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Categories/categories_page.dart';
import 'package:grocery/presentation/Most%20Popular/most_popular_page.dart';
import 'package:grocery/presentation/Popular%20Products/popular_product_page.dart';
import 'package:grocery/presentation/Top%20Discount%20Products/top_discount_page.dart';
import 'package:grocery/widgets/carousel/cus_carousel.dart';
import 'package:get/get.dart';
import '../../../widgets/app_bar/appbar.dart';
import '../../Cart/cart_controller.dart';
import '../../Language Selection/language_controller.dart';
import '../../Scanner/scanner_page.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    final HomeController controller = Get.put(HomeController());
    final CartController cartController = Get.put(CartController());

    return Directionality(
     textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(toolbarHeight: 110.h),
        body: Obx(() {
          if (controller.isLoading.value) {
           // return Center(child: CircularProgressIndicator(color: Colors.green,));
          }
          return RefreshIndicator(
            color: Color(0xFFEB1C23),
            backgroundColor: Colors.white,
            //strokeWidth: 2,
            onRefresh: controller.refreshData,
            child: ListView(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: languagecontroller.searchText,
                            hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon:
                            Icon(Icons.search, color: Color(0xFFEB1C23)),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 15.w,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                // CusCarousel(),
                SizedBox(height: 10.h),


                controller.isLaundrySelected.value
                    ? CategoriesPage()  // Show Laundry-specific content
                    : Column(
                  children: [
                    CusCarousel(),
                    SizedBox(height: 10.h),
                    CategoriesPage(),  // General categories
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40.w),
                            child: Text(
                              'ORDER YOUR CUSTOMIZED CAKE !!!',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
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
                  ],
                ),


                SizedBox(height: 20.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}
