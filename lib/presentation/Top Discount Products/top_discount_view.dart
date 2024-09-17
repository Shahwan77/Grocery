import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/organic/organic_model.dart';

import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';

class TopDiscountView extends StatelessWidget {
   TopDiscountView({super.key});
   final CartController cartController = Get.put(CartController());
   final FavoriteController favoriteController = Get.put(FavoriteController());



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Top Discount Products'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 20.0, // Space between columns
            mainAxisSpacing: 40.0, // Space between rows
            mainAxisExtent: 240
        ),
        itemCount:topImage.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 170.h, // Container height
                width: 160.w,  // Container width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.r,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                                  snackPosition: SnackPosition.TOP,
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
                    ),
                    Center(
                      child: Image.asset(
                        topImage[index],
                        fit: BoxFit.cover,
                        height: 80.h, // Image height
                        width: 80.w,  // Image width
                      ),
                    ),
                    Text(
                      toptext[index],
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start, // Ensures text is aligned consistently
                    ),
                    // Price and Cart Icon
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            topPrice[index],
                            style: TextStyle(
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
                                  snackPosition: SnackPosition.TOP,
                                );
                              },
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: cartController.isInCart(toptext[index])
                                    ? Colors.green.shade800
                                    : Colors.grey,
                              ),
                            );
                          }),                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
