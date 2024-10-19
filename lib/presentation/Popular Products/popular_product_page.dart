import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';
import '../Cart/cart_page.dart';
import '../Popular Products/popular_products_view.dart';
import '../favorite/fav_controller.dart';
import '../Products/products_controller.dart';
import '../home_screen/controller/home_controller.dart';

class PopularProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final FavoriteController favoriteController = Get.put(FavoriteController());
    final HomeController homeController = Get.put(HomeController());


    return Obx(() {
      if (homeController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (homeController.popularProducts.isEmpty) {
        return Center(child: Text("No popular products found."));
      } else {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: SizedBox(
                              width: 50.w,
                              height: 50.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFFEB1C23),
                              ),
                            ),
                          );
                        },
                      );

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                        Get.to(PopularProductsView());
                      });
                    },
                    child: Text(
                      'See all',
                      style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Color(0xFFEB1C23),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.popularProducts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == homeController.popularProducts.length) {
                      return Container(
                        width: 50.w,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.w,
                                    height: 50.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.w,
                                      color: Color(0xFFEB1C23),
                                    ),
                                  ),
                                );
                              },
                            );

                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                              Get.to(PopularProductsView());
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFFEB1C23),
                                width: 2.w,
                              ),
                            ),
                            child: Icon(
                              size: 40.sp,
                              Icons.arrow_forward_ios,
                              color: Color(0xFFEB1C23),
                            ),
                          ),
                        ),
                      );
                    }

                    final item = homeController.popularProducts[index];

                    return Container(
                      width: 150.w,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.grey.shade400)],
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
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
                                        favoriteController
                                                .isFavorite(itemData['name']!)
                                            ? 'Added to Favorites'
                                            : 'Removed from Favorites',
                                        '${itemData['name']} has been ${favoriteController.isFavorite(itemData['name']!) ? 'added to' : 'removed from'} your favorites.',
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    },
                                    child: Icon(
                                      favoriteController.isFavorite(item.name)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favoriteController
                                              .isFavorite(item.name)
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
                            Expanded(
                              child: Image.network(
                                '${Api.ImageUrl}/products/${item.image}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    '\$${item.price}',
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
                                          item.image,
                                          {}
                                        );

                                        Get.snackbar(
                                          cartController.isInCart(item.id)
                                              ? 'Added to Cart'
                                              : 'Removed from Cart',
                                          '${item.name} has been ${cartController.isInCart(item.id) ? 'added to' : 'removed from'} your cart.',
                                          snackPosition: SnackPosition.TOP,
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
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
