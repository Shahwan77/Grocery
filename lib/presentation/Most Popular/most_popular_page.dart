import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Cart/cart_controller.dart';
import '../home_screen/models/most_popular_models.dart';
import '../organic/organic_model.dart';

class MostPopularPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

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
                "Most Popular Categories",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              Text(
                "See all",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Colors.green.shade800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularItems.length,
            itemBuilder: (context, index) {
              final item = popularItems[index];
              return Container(
                width: 140.w,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey)],
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Colors.grey.shade100),
                  image: DecorationImage(
                    image: AssetImage(item.imagePath1),
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
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Center(
                        child: Text(
                          item.text,
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SizedBox(
            height: 220.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularItems.length,
              itemBuilder: (context, index) {
                final item = popularItems[index];
                return Container(
                  width: 150.w,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.favorite_border),
                          Icon(
                            Icons.info_outline,
                            color: Colors.green.shade800,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Image.asset(
                          mstImage[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        child: Text(
                          msttext[index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mstPrice[index],
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  cartController.toggleCart(
                                    msttext[index],
                                    mstPrice[index],
                                    mstImage[index],
                                  );                                  Get.snackbar(
                                    cartController.isInCart(msttext[index])
                                        ? 'Added to Cart'
                                        : 'Removed from Cart',
                                    '${msttext[index]} has been ${cartController.isInCart(msttext[index]) ? 'added to' : 'removed from'} your cart.',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: cartController.isInCart(msttext[index])
                                      ? Colors.green.shade800
                                      : Colors.grey,
                                ),
                              );
                            }),
                          ],
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
  }
}
