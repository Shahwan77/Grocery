import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';
import 'organic_model.dart';

class AllOrganicFood extends StatelessWidget {
  AllOrganicFood({super.key});
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 20.0, // Space between columns
          mainAxisSpacing: 40.0, // Space between rows
          mainAxisExtent: 240),
      itemCount: organicItems.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 240, // Container height
              width: 190, // Container width
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
                                'name': organicItems[index].name,
                                'price': organicItems[index].price,  // Assuming you have a list of prices
                                'image': organicItems[index].imagePath,  // Assuming you have a list of images
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
                              favoriteController.isFavorite(organicItems[index].name)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favoriteController.isFavorite(organicItems[index].name)
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
                      organicItems[index].imagePath, // Use imagePath from model
                      fit: BoxFit.cover,
                      height: 100, // Image height
                      width: 100, // Image width
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      organicItems[index].name,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          organicItems[index].price,
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              cartController.toggleCart(
                                organicItems[index].name,
                                organicItems[index].price,
                                organicItems[index].imagePath,
                              );
                              Get.snackbar(
                                cartController.isInCart(
                                  organicItems[index].name,
                                )
                                    ? 'Added to Cart'
                                    : 'Removed from Cart',
                                '${organicItems[index].name} has been ${cartController.isInCart(
                                  organicItems[index].name,
                                ) ? 'added to' : 'removed from'} your cart.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: cartController.isInCart(
                                organicItems[index].name,
                              )
                                  ? Colors.green.shade800
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ]),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
