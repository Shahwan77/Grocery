import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
import '../home_screen/controller/home_controller.dart';
import 'most_popular_view.dart';

class MostPopularPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: homeController.fetchPopularCategories(), // Call the fetch method here
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (homeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (homeController.popularCategories.isEmpty) {
          return
            Center(child: Text('No popular products found.'));
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languagecontroller.mostText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: SizedBox(
                              width: 50.w,
                              height: 50.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFFEB1C23),
                              ),
                            ),
                          );
                        },
                      );

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                        Get.to(MostPopularView());
                      });
                    },
                    child: Text(
                      languagecontroller.seeallText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Color(0xFFEB1C23),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SizedBox(
                height: 150.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.popularCategories.length,
                  itemBuilder: (context, index) {
                    final item = homeController.popularCategories[index];
                    return Container(
                      width: 140.w,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.grey)],
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade100),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${Api.ImageUrl}/categories/${item.image}',
                          ),
                          fit: BoxFit.contain,
                          alignment: Alignment(0, -1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
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
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
