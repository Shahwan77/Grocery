import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/organic/organic_model.dart';

import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';

class PopularProductsView extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Popular Products'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 20.0, // Space between columns
            mainAxisSpacing: 40.0, // Space between rows
            mainAxisExtent: 210
        ),
        itemCount:15,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 210, // Container height
                width: 190,  // Container width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
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
                    ),
                    Center(
                      child: Image.asset(
                        popImage[index],
                        fit: BoxFit.cover,
                        height: 100, // Image height
                        width: 100,  // Image width
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 10),
                      child: Text(
                        poptext[index],
                        style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start, // Ensures text is aligned consistently
                      ),
                    ),
                    // Price and Cart Icon
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            popPrice[index],
                            style: GoogleFonts.roboto(
                              fontSize: 10.sp,
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
                                );                                Get.snackbar(
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
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            );
                          }),            ],
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
