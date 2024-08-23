import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/presentation/Top%20Discount%20Products/top_discount_view.dart';
import '../Cart/cart_controller.dart';
import '../Cart/cart_page.dart';
import '../Popular Products/popular_products_view.dart';
import '../favorite/fav_controller.dart';
import '../organic/organic_model.dart';

class TopDiscountPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());


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
                'Top Discount Products',
                style: GoogleFonts.roboto(
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
                            color: Colors.green.shade800,
                          ),
                        ),
                      );
                    },
                  );

                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                    Get.to(TopDiscountView());
                  });
                },
                child: Text(
                  'See all',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SizedBox(
            height: 220.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topImage.length,
              itemBuilder: (context, index) {
                //final item = popularItems[index];
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
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return GestureDetector(
                              onTap: () {
                                final item = {
                                  'name': toptext[index],
                                  'price': topPrice[index],  // Assuming you have a list of prices
                                  'image': topImage[index],  // Assuming you have a list of images
                                };

                                favoriteController.toggleFavorite(
                                  item['name']!,
                                  item['price']!,
                                  item['image']!,
                                );

                                Get.snackbar(
                                  favoriteController.isFavorite(item['name']!)
                                      ? 'Added to Favorites'
                                      : 'Removed from Favorites',
                                  '${item['name']} has been ${favoriteController.isFavorite(item['name']!) ? 'added to' : 'removed from'} your favorites.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              child: Icon(
                                favoriteController.isFavorite(toptext[index])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteController.isFavorite(toptext[index])
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            );
                          }),
                          Icon(
                            Icons.info_outline,
                            color: Colors.green.shade800,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Image.asset(
                          topImage[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Text(
                          toptext[index],
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              topPrice[index],
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  cartController.toggleCart(
                                    toptext[index],
                                    topPrice[index],
                                    topImage[index],
                                  );                                  Get.snackbar(
                                    cartController.isInCart(toptext[index])
                                        ? 'Added to Cart'
                                        : 'Removed from Cart',
                                    '${toptext[index]} has been ${cartController.isInCart(toptext[index]) ? 'added to' : 'removed from'} your cart.',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: cartController.isInCart(toptext[index])
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
