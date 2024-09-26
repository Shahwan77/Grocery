import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Cart/cart_controller.dart';
import '../favorite/fav_controller.dart';
import '../Products/products_controller.dart';

class AllOrganicFood extends StatelessWidget {


  AllOrganicFood({super.key,});

  final ProductsController organicFoodController = Get.put(ProductsController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {

    organicFoodController.fetchProducts(2);

    return Obx(() {
      if (organicFoodController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (organicFoodController.productItems.isEmpty) {
        return Center(child: Text("No categories found."));
      } else {
        return GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20.0,
            mainAxisExtent: 200,
          ),
          itemCount: organicFoodController.productItems.length,
          itemBuilder: (context, index) {
            final item = organicFoodController.productItems[index];
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
                          child: Image.network(
                            'https://grocery-dev.greendomains.in/storage/images/products/${item.image}',
                            fit: BoxFit.cover,
                            height: 80.h,
                            width: 80.w,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 6.w),
                          child: Text(
                            item.name,
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
                              Text(
                                item.price,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Obx(() {

                                final isInLocalCart = cartController.isInCart(item.id);
                                final isInServerCart = cartController.fetchedcartItems.any((fetchedItem) => fetchedItem['product_id'] == item.id);

                                return GestureDetector(
                                  onTap: () {
                                    cartController.toggleCart(
                                      item.id, // Product ID
                                      item.name,
                                      item.price,
                                      item.image,
                                    );

                                    Get.snackbar(
                                      cartController.isInCart(item.id)
                                          ? 'Added to Cart'
                                          : 'Removed from Cart',
                                      '${item.name} has been ${cartController.isInCart(item.id) ? 'added to' : 'removed from'} your cart.',
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  },
                                  child:

                                  Icon(
                                    isInLocalCart || isInServerCart
                                        ? Icons.shopping_cart
                                        : Icons.shopping_cart_outlined,
                                    color: isInLocalCart || isInServerCart
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
                ),
              ],
            );
          },
        );
      }
    });
  }
}
