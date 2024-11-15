import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
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
    final WelcomeController languageController = Get.put(WelcomeController());

    return FutureBuilder<void>(
      future: homeController.fetchPopularProducts(), // Call the fetch function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Show error message if something went wrong
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (homeController.popularProducts.isEmpty) {
            // Show a message if no products are found
            return Center(child: Text("No popular products found."));
          } else {
            // Show popular products if data is successfully fetched
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageController.popularText,
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
                          languageController.seeallText,
                          style: TextStyle(
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                        final isInCart = isInLocalCart || isInServerCart;

                                        return GestureDetector(
                                          onTap: isInCart
                                              ? null
                                              : () {
                                            cartController.toggleCart(
                                              item.id,
                                              item.name,
                                              item.price,
                                              item.image,
                                              {},
                                            );
                                          },
                                          child: Icon(
                                            isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                                            color: isInCart ? Color(0xFFEB1C23) : Colors.grey,
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
        } else {
          // Handle other states
          return SizedBox();
        }
      },
    );
  }
}
