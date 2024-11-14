import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
import '../favorite/fav_controller.dart';
import '../home_screen/controller/home_controller.dart';

class TopDiscountView extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final HomeController productsController = Get.put(HomeController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading:  IconButton(
            icon: Container(
                height: 22.h,width: 26.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r)
                ),
                child: Center(child: Icon(Icons.arrow_back_ios_rounded,color: Color(0xFFEB1C23),size: 20.sp,))),
            onPressed: () {
              Get.back();
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFFEB1C23),
          title: Text(languagecontroller.topText,style: TextStyle(color: Colors.white),),
        ),
        body: Obx(() {
          if (productsController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (productsController.discountProducts.isEmpty) {
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
              itemCount: productsController.discountProducts.length,
              itemBuilder: (context, index) {
                final item = productsController.discountProducts[index];
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
                                '${Api.ImageUrl}/products/${item.image}',
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
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
                                    final isInServerCart = cartController.fetchedcartItems
                                        .any((fetchedItem) => fetchedItem['product_id'] == item.id);
      
                                    final isInCart = isInLocalCart || isInServerCart; // Check if item is in local or server cart
      
                                    return GestureDetector(
                                      onTap: isInCart // Disable onTap if already in cart
                                          ? null // Disable the action if item is already in the cart
                                          : () {
                                        cartController.toggleCart(
                                          item.id, // Product ID
                                          item.name,
                                          item.price,
                                          item.image,{}
                                        );
      
                                        Get.snackbar(
                                          cartController.isInCart(item.id)
                                              ? 'Added to Cart'
                                              : 'Removed from Cart',
                                          '${item.name} has been ${cartController.isInCart(item.id) ? 'added to' : 'removed from'} your cart.',
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
        }),
      ),
    );
  }
}
