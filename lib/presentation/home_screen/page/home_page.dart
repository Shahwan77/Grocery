import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Categories/categories_page.dart';
import 'package:grocery/presentation/Categories/laundry_categories.dart';
import 'package:grocery/presentation/Most%20Popular/most_popular_page.dart';
import 'package:grocery/presentation/Popular%20Products/popular_product_page.dart';
import 'package:grocery/presentation/Promotions/promotion_product.dart';
import 'package:grocery/presentation/Top%20Discount%20Products/top_discount_page.dart';
import 'package:grocery/widgets/carousel/cus_carousel.dart';
import 'package:get/get.dart';
import '../../../data/apiClient/api.dart';
import '../../../widgets/app_bar/appbar.dart';
import '../../AJ.dart';
import '../../Cart/cart_controller.dart';
import '../../Language Selection/language_controller.dart';
import '../../Promotions/promotion_product_controller.dart';
import '../../Promotions/promotions_page.dart';
import '../../Search/search_controller.dart';
import '../../Search/search_page.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
    HomePage({super.key});
  final WelcomeController languageController = Get.put(WelcomeController());
  final HomeController controller = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());
  final PromoController promotionController = Get.put(PromoController());
  final SearchPoductController searchController = Get.put(SearchPoductController());
  @override
  Widget build(BuildContext context) {

      promotionController.fetchPromotion();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(toolbarHeight: 110.h),
        body: Obx(() {
          if (controller.isLoading.value) {
            // Loading logic here
            return Center(
                child: CircularProgressIndicator(color: Colors.green));
          }
          // if (controller.promotionsList.isEmpty) {
          //   // Handle case when promotions list is empty
          //   return Center(
          //     child: Text('No promotions available'),
          //   );
          // };
          return RefreshIndicator(
            color: Color(0xFFEB1C23),
            backgroundColor: Colors.white,
            onRefresh: controller.refreshData,
            child: ListView(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextField(
                    controller: searchController.searchTextController,
                    decoration: InputDecoration(
                      hintText: languageController.searchText,
                      hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Color(0xFFEB1C23)),
                        onPressed: () {
                          // Navigate to SearchPage with the query
                          String query =
                              searchController.searchTextController.text.trim();
                          if (query.isNotEmpty) {
                            searchController.searchProducts(query);
                            Get.to(() => SearchPage(query: query));
                          }
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 15.w),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 10.h),
                if (controller.isLaundrySelected.value)
                  LaundryCategories()
                else if (controller.isOfferSelected.value)
                  PromotionsPage()
                else if (controller.isAjSelected.value)
                    AjPage()
                else if (controller.isGrocerySelected.value)
                  Column(
                    children: [
                      if (promotionController.promotionResponse.value != null )
                        GestureDetector(
                          onTap: () {
                            var data = promotionController.promotionResponse.value!.data;
                            Get.to(() => PromoProductsPage(promotionName: data.name));
                          },
                          child: CusCarousel(),
                        ),

                      SizedBox(height: 10.h),
                      CategoriesPage(), // General categories
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: EdgeInsets.only(right: 40.w),
                      //         child: Text(
                      //           languageController.customizedcakeText,
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.w600,
                      //             fontSize: 18.sp,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(height: 10.h),
                      //       Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 2.w),
                      //         child: Container(
                      //           height: 150.h,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20.r),
                      //             color: Colors.transparent,
                      //             image: DecorationImage(
                      //               image: AssetImage('assets/gro4.png'),
                      //               fit: BoxFit.fill,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: ScreenUtil().screenWidth >600?40.h:1.h),
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
