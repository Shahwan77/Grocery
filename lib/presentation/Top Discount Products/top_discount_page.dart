import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/presentation/Top%20Discount%20Products/top_discount_view.dart';
import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
import '../favorite/fav_controller.dart';
import '../home_screen/controller/home_controller.dart';

class TopDiscountPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final HomeController homeController = Get.find<HomeController>();
  final WelcomeController languagecontroller = Get.put(WelcomeController());



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: homeController.fetchDiscountProducts(), // Call the fetchDiscountProducts method
      builder: (context, snapshot) {
        // Show a loading indicator while the future is being executed
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error fetching discount products: ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          // After the future is complete, display the data or handle empty list
          if (homeController.discountProducts.isEmpty) {
            return Center(child: Text('No Discount Products Available'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languagecontroller.topText,
                        style: TextStyle(
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
                                    strokeWidth: 2.w,
                                    color: Color(0xFFEB1C23),
                                  ),
                                ),
                              );
                            },
                          );

                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop();
                            Get.to(TopDiscountView());
                          });
                        },
                        child: Text(
                          languagecontroller.seeallText,
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
                      itemCount: homeController.discountProducts.length > 2
                          ? 2
                          : homeController.discountProducts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == homeController.discountProducts.length) {
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
                                  Get.to(TopDiscountView());
                                });
                              },
                              child: Icon(
                                size: 40.sp,
                                Icons.arrow_forward,
                                color: Color(0xFFEB1C23),
                              ),
                            ),
                          );
                        }
                        final item = homeController.discountProducts[index];
                        return Container(
                          width: 150.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey.shade100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return GestureDetector(
                                        onTap: () {
                                          favoriteController.toggleFavorite(
                                            item.product.name,
                                            item.price.toString(),
                                            item.product.image,
                                          );

                                          Get.snackbar(
                                            favoriteController.isFavorite(item.product.name)
                                                ? 'Added to Favorites'
                                                : 'Removed from Favorites',
                                            '${item.product.name} has been ${favoriteController.isFavorite(item.product.name) ? 'added to' : 'removed from'} your favorites.',
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        },
                                        child: Icon(
                                          favoriteController.isFavorite(item.product.name)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: favoriteController.isFavorite(item.product.name)
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
                                    '${Api.ImageUrl}/products/${item.product.image}',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      item.product.name,
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
                                      // Check if promotionPrice is null
                                      if (item.promotionPrice == null)
                                        Text(
                                          '\AED${item.price}',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      else
                                      // If promotionPrice is not null, show both prices
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\AED${item.price}',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w700,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Text(
                                              '\AED${item.promotionPrice}',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      Obx(() {
                                        final isInLocalCart = cartController.isInCart(item.id);
                                        final isInServerCart = cartController.fetchedcartItems
                                            .any((fetchedItem) => fetchedItem['product_id'] == item.id);

                                        final isInCart = isInLocalCart || isInServerCart;
                                        String priceToPost = item.price.toString();
                                        if (item.promotionPrice != null) {
                                          priceToPost = item.promotionPrice.toString(); // Use promotionPrice if it's not null
                                        }
                                        return GestureDetector(
                                          onTap: isInCart
                                              ? null
                                              : () {
                                            cartController.toggleCart(
                                              {}.toString(),
                                              item.id,
                                              item.product.name,
                                              priceToPost,
                                              item.product.image,
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
        }
        return SizedBox(); // Fallback if the state is not managed properly
      },
    );
  }
}
