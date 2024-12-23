import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final token = GetStorage().read('access_token');
  Map<int, RxInt> quantityMap = {};

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
            return Center(child: Text(''));
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
                          fontSize: ScreenUtil().screenWidth >600?16.sp:18.sp,
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
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.discountProducts.length > 2
                          ? 3
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
                        RxBool isSelected = false.obs;
                        RxInt quantity = 1.obs;
                        quantityMap.putIfAbsent(item.product.id, () => 1.obs);
                        return GestureDetector(

                          onTap:  () {
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
                          child: Container(
                            width: 150.w,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.grey.shade400)],
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.favorite_border,
                                            color: Colors.grey,
                                          ),
                                          Icon(
                                            Icons.info_outline,
                                            color: Colors.green.shade800,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Image.network(
                                          '${Api.ImageUrl}/products/${item.product.image}',
                                          fit: BoxFit.contain,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                            if (item.promotionPrice == null)
                                              Text(
                                                '\AED${item.price}',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            else
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
                                              final isInLocalCart = cartController.isInCart(item.product.id);
                                              final isInServerCart = cartController.fetchedcartItems
                                                  .any((fetchedItem) => fetchedItem['product_id'] == item.product.id);

                                              final isInCart = isInLocalCart || isInServerCart;

                                              return GestureDetector(
                                                onTap: isInCart
                                                    ? null
                                                    : () {
                                                  String priceToPost = item.price.toString();
                                                  if (item.promotionPrice != null) {
                                                    priceToPost = item.promotionPrice.toString(); // Use promotionPrice if it's not null
                                                  }
                                                  cartController.toggleCart(
                                                    null,
                                                    {}.toString(),
                                                    item.product.id,
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
                                Obx(() {
                                  final quantity = quantityMap[item.product.id]!.value;
                                  return isSelected.value
                                      ? Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(13.r),
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
        return SizedBox();
      },
    );
  }
}
