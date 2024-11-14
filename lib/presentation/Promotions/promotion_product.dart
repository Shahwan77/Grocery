import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Promotions/promotion_product_controller.dart';

import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';

class PromoProductsPage extends StatelessWidget {
  final String promotionName;
  PromoProductsPage({required this.promotionName});  // Update the constructor


  @override
  Widget build(BuildContext context) {
    final PromoController promotionController = Get.put(PromoController());
    final CartController cartController = Get.put(CartController());
    return Scaffold(
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
        title: Text("$promotionName",style: TextStyle(color: Colors.white),),
      ),
      body: Obx(() {
        if (promotionController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (promotionController.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${promotionController.errorMessage}'));
        } else if (promotionController.promotionResponse.value == null) {
          return Center(child: Text('No data available.'));
        } else {
          var data = promotionController.promotionResponse.value!.data;
          return GridView.builder(
            itemCount: data.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              mainAxisExtent: GetStorage().read('selectedButton') == 'laundry' ? 220.h : 190.h,
            ),
            itemBuilder: (context, index) {
              final item = data.items[index];
              return IntrinsicHeight(
                child: Container(
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
                            Icon(Icons.favorite_border),
                            Icon(Icons.info_outline)
                          ],
                        ),
                        Center(
                          child: Image.network(
                            fit: BoxFit.cover,
                            width: 100.w,
                            '${Api.ImageUrl}/products/${item.product.image}',
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                children: [
                                  Text(
                                    '\$${item.product.price}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '\$${item.promotionPrice}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() {
                                final isInLocalCart = cartController.isInCart(item.product.id);
                                final isInServerCart = cartController.fetchedcartItems
                                    .any((fetchedItem) => fetchedItem['product_id'] == item.product.id);

                                final isInCart = isInLocalCart || isInServerCart; // Check if item is in local or server cart

                                return GestureDetector(
                                  onTap: isInCart // Disable onTap if already in cart
                                      ? null // Disable the action if item is already in the cart
                                      : () {
                                    cartController.toggleCart(
                                        item.product.id, // Product ID
                                        item.product.name,
                                        item.promotionPrice as String,
                                        item.product.image,
                                        {}
                                    );

                                    // Get.snackbar(
                                    //   cartController.isInCart(item.id)
                                    //       ? 'Added to Cart'
                                    //       : 'Removed from Cart',
                                    //   '${item.name} has been ${cartController.isInCart(item.id) ? 'added to' : 'removed from'} your cart.',
                                    //   snackPosition: SnackPosition.TOP,
                                    // );
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
              );
            },
          );
        }
      }),
    );
  }
}
