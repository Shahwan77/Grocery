import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';
import '../organic/organic_controller.dart';

class Juices extends StatelessWidget {
  const Juices ({super.key});

  @override
  Widget build(BuildContext context) {

    final OrganicFoodController organicFoodController = Get.put(OrganicFoodController());
    final CartController cartController = Get.put(CartController());
    final FavoriteController favoriteController = Get.put(FavoriteController());
    organicFoodController.fetchProducts(9);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'JUICES',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Obx(() {
        if (organicFoodController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (organicFoodController.productItems.isEmpty) {
          return Center(child: Text("No categories found."));
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
              mainAxisExtent: 200,
            ),
            itemCount: organicFoodController.productItems.length,
            itemBuilder: (context, index) {
              final item = organicFoodController.productItems[index];
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: 160,
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
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.price,
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
        }
      }),
    );
  }
}
