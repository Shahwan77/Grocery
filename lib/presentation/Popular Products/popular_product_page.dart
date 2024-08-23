import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Cart/cart_controller.dart';
import '../Cart/cart_page.dart';
import '../Popular Products/popular_products_view.dart';
import '../favorite/fav_controller.dart';
import '../organic/organic_model.dart';

class PopularProductPage extends StatelessWidget {
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
                'Popular Products',
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
                    Get.to(PopularProductsView());
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
              itemCount: 6 + 1,
              itemBuilder: (context, index) {
                if (index == 6) {
                  return Container(
                    width: 50.w,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    alignment: Alignment.center,
                    child: GestureDetector(
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
                          Get.to(PopularProductsView());
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green.shade800,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          size: 40,
                          Icons.arrow_forward_ios,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                  width: 150.w,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.shade400)],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return GestureDetector(
                              onTap: () {
                                final item = {
                                  'name': poptext[index],
                                  'price': popPrice[index],  // Assuming you have a list of prices
                                  'image': popImage[index],  // Assuming you have a list of images
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
                                favoriteController.isFavorite(poptext[index])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteController.isFavorite(poptext[index])
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
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                popImage[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          poptext[index],
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              popPrice[index],
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  cartController.toggleCart(
                                    poptext[index],
                                    popPrice[index],
                                    popImage[index],
                                  );
                                  Get.snackbar(
                                    cartController.isInCart(poptext[index])
                                        ? 'Added to Cart'
                                        : 'Removed from Cart',
                                    '${poptext[index]} has been ${cartController.isInCart(poptext[index]) ? 'added to' : 'removed from'} your cart.',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: cartController.isInCart(poptext[index])
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
