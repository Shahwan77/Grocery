import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/models.dart';
import '../Cart/cart_controller.dart';
import '../Products/products_controller.dart';
import '../favorite/fav_controller.dart';

class DetailPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final ProductsController productController = Get.put(ProductsController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  DetailPage({required this.categoryId, required this.categoryName,});

  @override
  Widget build(BuildContext context) {
    productController.fetchProducts(int.parse(categoryId));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(categoryName,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green.shade800,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (productController.productItems.isEmpty) {
          return Center(child: Text("No products found."));
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
              mainAxisExtent: 200,
            ),
            itemCount: productController.productItems.length,
            itemBuilder: (context, index) {
              final item = productController.productItems[index];
              return Column(
                children: [
                  IntrinsicHeight(
                    child: Container(
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
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
                            child: item.image.isNotEmpty
                                ? Image.network(
                              'https://grocery-dev.greendomains.in/storage/images/products/${item.image}',
                              fit: BoxFit.cover,
                              height: 80.h,
                              width: 80.w,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.hide_image_outlined,
                                size: 90.sp,
                                color: Colors.grey,
                              ),
                            )
                                : Icon(
                              Icons.hide_image_outlined,
                              size: 90.sp,
                              color: Colors.grey,
                            ),
                          ),


                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
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
