import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Cart/cart_controller.dart';
import '../Cart/cart_page.dart';
import '../Popular Products/popular_products_view.dart';
import '../favorite/fav_controller.dart';
import '../Products/products_controller.dart'; // Import your ProductsController

class PopularProductPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    // Fetch popular products from the API
    productsController.fetchPopularProducts(); // Ensure this method is defined in ProductsController

    return Obx(() {
      if (productsController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (productsController.productItems.isEmpty) {
        return Center(child: Text("No popular products found."));
      } else {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                                color: Colors.green.shade800,
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
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productsController.productItems.length + 1,
                  itemBuilder: (context, index) {
                    if (index == productsController.productItems.length) {
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
                                      color: Colors.green.shade800,
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
                                color: Colors.green.shade800,
                                width: 2.w,
                              ),
                            ),
                            child: Icon(
                              size: 40.sp,
                              Icons.arrow_forward_ios,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ),
                      );
                    }

                    final item = productsController.productItems[index];

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
                                        favoriteController.isFavorite(itemData['name']!)
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
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://grocery-dev.greendomains.in/storage/images/products/${item.image}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      },
                                      child: Icon(
                                        cartController.isInCart(item.name)
                                            ? Icons.shopping_cart
                                            : Icons.shopping_cart_outlined,
                                        color: cartController.isInCart(item.name)
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
