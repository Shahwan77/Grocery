import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';
import '../Categories/categories_detail.dart';
import '../Language Selection/language_controller.dart';
import '../favorite/fav_controller.dart';
import '../home_screen/controller/home_controller.dart';

class MostPopularView extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final HomeController homeController = Get.put(HomeController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
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
          title: Text(languagecontroller.mostText,style: TextStyle(color: Colors.white),),
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
                mainAxisExtent: ScreenUtil().screenWidth >600?220:160,
              ),
              itemCount: homeController.popularCategories.length,
              itemBuilder: (context, index) {
                final item = homeController.popularCategories[index];
                final category = homeController.categories[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailPage(
                      categoryId: category.id.toString(),
                      categoryName: category.name,
                    ));
                  },
                  child: Container(
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
                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: ScreenUtil().screenWidth >600?0.h:10.h),
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
