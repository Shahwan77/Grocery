import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/presentation/Top%20Discount%20Products/top_discount_view.dart';
import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';
import '../home_screen/controller/home_controller.dart';

class TopDiscountPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 11.w,vertical: 10.h),
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
                            strokeWidth: 2.w,
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
        Obx(() {
          if (homeController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (homeController.discountProducts.isEmpty) {
            return Center(child: Text('No Discount Products Available'));
          } else {
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w),
              child: SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.discountProducts.length,
                  itemBuilder: (context, index) {
                    final item = homeController.discountProducts[index];
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return GestureDetector(
                                    onTap: () {
                                      favoriteController.toggleFavorite(
                                        item.name,
                                        item.price.toString(),
                                        item.image,
                                      );

                                      Get.snackbar(
                                        favoriteController.isFavorite(item.name)
                                            ? 'Added to Favorites'
                                            : 'Removed from Favorites',
                                        '${item.name} has been ${favoriteController.isFavorite(item.name) ? 'added to' : 'removed from'} your favorites.',
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    },
                                    child: Icon(
                                      favoriteController.isFavorite(item.name)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favoriteController.isFavorite(item.name)
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
                              child: Image.network(
                                'https://grocery-dev.greendomains.in/storage/images/products/${item.image}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${item.price}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Obx(() {
                                    return GestureDetector(
                                      onTap: () {
                                        cartController.toggleCart(
                                          item.name,
                                          item.price,
                                          item.image,
                                        );
                                        Get.snackbar(
                                          cartController.isInCart(item.name)
                                              ? 'Added to Cart'
                                              : 'Removed from Cart',
                                          '${item.name} has been ${cartController.isInCart(item.name) ? 'added to' : 'removed from'} your cart.',
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      },
                                      child: Icon(
                                        cartController.isInCart(item.name)
                                            ? Icons.shopping_cart
                                            : Icons.shopping_cart_outlined,
                                        color: cartController.isInCart(item.name)
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}
