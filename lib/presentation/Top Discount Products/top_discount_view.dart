import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
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
  final token = GetStorage().read('access_token');
  Map<int, RxInt> quantityMap = {};
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
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 14.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  2,
                crossAxisSpacing: GetStorage().read('selectedButton') == 'laundry' ? 18 : 18,
                mainAxisSpacing: GetStorage().read('selectedButton') == 'laundry' ? 20 : 20,
                mainAxisExtent: ScreenUtil().screenWidth >600? GetStorage().read('selectedButton') == 'laundry' ? 400 :290 : GetStorage().read('selectedButton') == 'grocery'?230:280,
              ),
              itemCount: productsController.popularProducts.length,
              itemBuilder: (context, index) {
                final item = productsController.popularProducts[index];
                RxBool isSelected = false.obs;
                quantityMap.putIfAbsent(item.product.id, () => 1.obs);
                return GestureDetector(
                  onTap: () {
                    isSelected.value = !isSelected.value;
                    if (isSelected.value) {
                      String priceToPost = item.price.toString();
                      if (item.promotionPrice != null) {
                        priceToPost = item.promotionPrice.toString(); // Use promotionPrice if it's not null
                      }
                      cartController.toggleCart(
                        null,
                        {}.toString(),
                        item.productId,
                        item.product.name,
                        priceToPost,
                        item.product.image,
                        {},
                      );
                    }// Toggle the selected state
                  },
                  child: IntrinsicHeight(
                    child: Container(
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                          children: [Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    ),
                                    // Obx(() {
                                    //   return GestureDetector(
                                    //     onTap: () {
                                    //       final itemData = {
                                    //         'name': item.product.name,
                                    //         'price': item.product.price,
                                    //         'image': item.product.image,
                                    //       };
                                    //
                                    //       favoriteController.toggleFavorite(
                                    //         itemData['name']!,
                                    //         itemData['price']!,
                                    //         itemData['image']!,
                                    //       );
                                    //
                                    //       Get.snackbar(
                                    //         favoriteController.isFavorite(itemData['name']!)
                                    //             ? 'Added to Favorites'
                                    //             : 'Removed from Favorites',
                                    //         '${itemData['name']} has been ${favoriteController.isFavorite(itemData['name']!) ? 'added to' : 'removed from'} your favorites.',
                                    //         snackPosition: SnackPosition.BOTTOM,
                                    //       );
                                    //     },
                                    //     child: Icon(
                                    //       favoriteController.isFavorite(item.product.name)
                                    //           ? Icons.favorite
                                    //           : Icons.favorite_border,
                                    //       color: favoriteController.isFavorite(item.product.name)
                                    //           ? Color(0xFFEB1C23)
                                    //           : Colors.grey,
                                    //     ),
                                    //   );
                                    // }),
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
                                  height: 100.h,
                                  width: 100.w,
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
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
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
                                      final isInLocalCart = cartController.isInCart(item.productId);
                                      final isInServerCart = cartController.fetchedcartItems
                                          .any((fetchedItem) => fetchedItem['product_id'] == item.productId);

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
                                            null,
                                            {}.toString(),
                                            item.productId,
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
                            Obx(() {
                              final quantity = quantityMap[item.product.id]!.value;
                              return isSelected.value
                                  ? Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14.r),
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                          ),
                                          onPressed: () {
                                            if (quantity > 1) {
                                              // Reduce the quantity by 1
                                              cartController.updateQuantity(item.product.id, -1);
                                              quantityMap[item.product.id]!.value = quantity - 1; // Update using .value
                                            } else {
                                              // If quantity is 1, remove the item from the cart
                                              final productId = item.product.id;
                                              if (token != null) {
                                                cartController.removeItemFromCart(productId);
                                                isSelected.value = false;
                                              } else {
                                                cartController.removeFromCart(
                                                  item.product.name,
                                                  (item.product.price ?? 0).toString(),
                                                  item.product.image,
                                                  item.product.type,
                                                );
                                                isSelected.value = false;
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      Text(
                                        '${quantity}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14.r),
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.green.shade800,
                                          ),
                                          onPressed: () {
                                            cartController.updateQuantity(item.product.id, 1);
                                            quantityMap[item.product.id]!.value = quantity + 1; // Update using .value
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  : SizedBox.shrink();
                            }),

                          ]
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
