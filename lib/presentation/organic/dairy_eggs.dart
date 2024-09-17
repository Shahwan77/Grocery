import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';
import 'organic_model.dart';

class DairyEggs extends StatelessWidget {
   DairyEggs({super.key});
   final CartController cartController = Get.put(CartController());
   final FavoriteController favoriteController = Get.put(FavoriteController());


   @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(9.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 40.0,
        mainAxisExtent: 250,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 200.h, // Container height
              width: 190.w, // Container width
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
                                'name': text1[index],
                                'price': Price1[index],  // Assuming you have a list of prices
                                'image': imageUrls[index],  // Assuming you have a list of images
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
                              favoriteController.isFavorite(text1[index])
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favoriteController.isFavorite(text1[index])
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
                    child: Image.network(
                      imageUrls[
                      index], // Use imagePath from model
                      fit: BoxFit.cover,
                      height: 80.h, // Image height
                      width: 80.w, // Image width
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      text1[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Price1[index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              cartController.toggleCart(
                                text1[index],
                                Price1[index],
                                imageUrls[index],
                              );
                              Get.snackbar(
                                cartController.isInCart(text1[index])
                                    ? 'Added to Cart'
                                    : 'Removed from Cart',
                                '${text1[index]} has been ${cartController.isInCart(text1[index]) ? 'added to' : 'removed from'} your cart.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: cartController
                                  .isInCart(text1[index])
                                  ? Colors.green.shade800
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ]
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
