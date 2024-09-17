import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';
import 'organic_controller.dart';

class AllOrganicFood extends StatelessWidget {
  final int categoryId;

  AllOrganicFood({super.key, required this.categoryId});

  final OrganicFoodController organicFoodController = Get.put(OrganicFoodController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    // Fetch organic foods for the given category ID
    organicFoodController.fetchOrganicFoods(2);

    return Obx(() {
      if (organicFoodController.organicItems.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 50.0,
          mainAxisExtent: 220,
        ),
        itemCount: organicFoodController.organicItems.length,
        itemBuilder: (context, index) {
          final item = organicFoodController.organicItems[index];
          return Column(
            children: [
              Container(
                height: 210,
                width: 190,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
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
                                final itemData = {
                                  'name': item.name,
                                  'price': item.price,
                                  'image': item.image,
                                };

                                favoriteController.toggleFavorite(
                                  itemData['name']!,
                                  itemData['price']!,
                                  itemData['image']!,
                                );

                                Get.snackbar(
                                  favoriteController.isFavorite(itemData['name']!)
                                      ? 'Added to Favorites'
                                      : 'Removed from Favorites',
                                  '${itemData['name']} has been ${favoriteController.isFavorite(itemData['name']!) ? 'added to' : 'removed from'} your favorites.',
                                  snackPosition: SnackPosition.BOTTOM,
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
                    ),
                    Center(
                      child: Image.network(
                        'https://grocery-dev.greendomains.in/storage/images/products/${item.image}',
                        fit: BoxFit.cover,
                        height: 80, // Image height
                        width: 80, // Image width
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: Text(
                        item.name,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.price,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
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
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: cartController.isInCart(item.name)
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
              ),
            ],
          );
        },
      );
    });
  }
}
