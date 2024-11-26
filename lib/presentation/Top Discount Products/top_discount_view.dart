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
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10.0,
                mainAxisExtent: 220,
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
                                          'name': item.product.name,
                                          'price': item.product.price,
                                          'image': item.product.image,
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
                            ),
                            Center(
                              child: Image.network(
                                '${Api.ImageUrl}/products/${item.product.image}',
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 6.w),
                              child: Text(
                                item.product.name,
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
