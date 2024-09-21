import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';
import '../home_screen/controller/home_controller.dart';

class MostPopularView extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Most Popular Categories'),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (homeController.popularCategories.isEmpty) {
          return Center(child: Text("No categories found."));
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(8.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20.0,
              mainAxisExtent: 160,
            ),
            itemCount: homeController.popularCategories.length,
            itemBuilder: (context, index) {
              final item = homeController.popularCategories[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${Api.ImageUrl}/categories/${item.image}',
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                      child: Center(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
