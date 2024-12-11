import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../data/apiClient/api.dart';
import '../data/models/aj_models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Cart/cart_controller.dart';
import 'favorite/fav_controller.dart';
import 'home_screen/controller/home_controller.dart';

class AjPage extends StatelessWidget {
  AjPage({Key? key}) : super(key: key);
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final HomeController ajController = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ajController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (ajController.ajProducts.isEmpty) {
        return const Center(child: Text('No promotions available'));
      } else {
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          itemCount: ajController.ajProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75, // Adjust aspect ratio to suit item content
          ),
          itemBuilder: (context, index) {
            final product = ajController.ajProducts[index];
            return Column(
              children: [
                IntrinsicHeight(
                  child: Container(
                    width: 160.w,
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
                                    final itemData = {
                                      'name': product.name,
                                      'price':product.price,
                                      'image': product.image,
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
                                    favoriteController.isFavorite(product.name)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favoriteController.isFavorite(product.name)
                                        ? Color(0xFFEB1C23)
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
                            '${Api.ImageUrl}/aj/${product.image}',
                            fit: BoxFit.cover,
                            height: 80.h,
                            width: 80.w,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 6.w),
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\AED ${product.price}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      // color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      // decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: 4.w,),
                                  // Text(
                                  //   '\AED${product.promotionPrice}',
                                  //   style: TextStyle(
                                  //     fontSize: 10.sp,
                                  //     fontWeight: FontWeight.w700,
                                  //   ),
                                  // ),
                                ],
                              ),

                              Obx(() {
                                final isInLocalCart = cartController.isInCart(product.id);
                                final isInServerCart = cartController.fetchedcartItems
                                    .any((fetchedItem) => fetchedItem['product_id'] == product.id);

                                final isInCart = isInLocalCart || isInServerCart; // Check if item is in local or server cart

                                return GestureDetector(
                                  onTap: isInCart // Disable onTap if already in cart
                                      ? null // Disable the action if item is already in the cart
                                      : () {
                                    cartController.toggleCart(
                                        null,
                                        {}.toString(),
                                        product.id, // Product ID
                                        product.name,
                                       product.price,
                                       product.image,
                                        {}
                                    );

                                    Get.snackbar(
                                      cartController.isInCart(product.id)
                                          ? 'Added to Cart'
                                          : 'Removed from Cart',
                                      '${product.name} has been ${cartController.isInCart(product.id) ? 'added to' : 'removed from'} your cart.',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  },
                                  child: Icon(
                                    isInCart
                                        ? Icons.shopping_cart // Show filled cart if item is in cart
                                        : Icons.shopping_cart_outlined, // Show empty cart if item is not in cart
                                    color: isInCart ? Color(0xFFEB1C23) : Colors.grey, // Change icon color
                                  ),
                                );
                              }),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
