import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/models.dart';
import '../../Cart/cart_controller.dart';
import '../../Products/products_controller.dart';

import 'package:http/http.dart' as http;

import '../../favorite/fav_controller.dart';

class HerbsSpices extends StatelessWidget {
  final CartController cartController = Get.find();
  final FavoriteController favoriteController = Get.find();
  final ProductsController productsController = Get.put(ProductsController());


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Models>>(
      future: productsController.fetchRiceCakes(7),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No herbs & spices available'));
        } else {
          final products = snapshot.data!;

          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20.0,
              mainAxisExtent: 200,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Column(
                children: [
                  IntrinsicHeight(
                    child: Container(
                      width: 160.w, // Keep the width fixed
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
                                        'name': product.name,
                                        'price': product.price,
                                        'image': product.image,
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
                                      favoriteController.isFavorite(product.name)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favoriteController.isFavorite(product.name)
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
                            child: product.image.isNotEmpty
                                ? Image.network(
                              'https://grocery-dev.greendomains.in/storage/images/products/${product.image}',
                              fit: BoxFit.cover,
                              height: 80.h, // Image height
                              width: 80.w, // Image width
                            )
                                : Icon(
                              Icons.image,
                              size: 80.w,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Text(
                              product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.price.isNotEmpty
                                        ? product.price
                                        : '00', // Default price
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Obx(() {
                                    return GestureDetector(
                                      onTap: () {
                                        cartController.toggleCart(
                                          product.name,
                                          product.price ?? '0',
                                          product.image ?? '',
                                        );
                                        Get.snackbar(
                                          cartController.isInCart(product.name)
                                              ? 'Added to Cart'
                                              : 'Removed from Cart',
                                          '${product.name} has been ${cartController.isInCart(product.name) ? 'added to' : 'removed from'} your cart.',
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      },
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: cartController.isInCart(product.name)
                                            ? Colors.green.shade800
                                            : Colors.grey,
                                      ),
                                    );
                                  }),
                                ]
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
      },
    );
  }
}
