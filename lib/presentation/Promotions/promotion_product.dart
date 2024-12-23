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

  PromoProductsPage({required this.promotionName});

  @override
  Widget build(BuildContext context) {
    final PromoController promotionController = Get.put(PromoController());
    final CartController cartController = Get.put(CartController());
    final token = GetStorage().read('access_token');

    // Maps to track selection state and quantities
    Map<int, RxBool> itemSelectionMap = {};
    Map<int, RxInt> quantityMap = {}; // Change to RxInt

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Container(
                height: 22.h,
                width: 26.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xFFEB1C23),
                    size: 20.sp,
                  ),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xFFEB1C23),
            title: Text(
              promotionName,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: FutureBuilder(
            future: promotionController.fetchPromotion(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (promotionController.promotionResponse.value == null) {
                return Center(child: Text('No data available.'));
              } else {
                var data = promotionController.promotionResponse.value!.data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: data.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10.h,
                      mainAxisExtent:
                          GetStorage().read('selectedButton') == 'laundry'
                              ? 220.h
                              : 178.h,
                    ),
                    itemBuilder: (context, index) {
                      final item = data.items[index];
                      // Initialize selection and quantity if not already done
                      RxBool isSelected = false.obs;
                      quantityMap.putIfAbsent(
                          item.product.id, () => 1.obs); // Change to RxInt

                      return GestureDetector(
                          onTap: () {
                            isSelected.value = !isSelected.value;
                            if (isSelected.value) {
                              double priceToPost = item.product.price;
                              if (item.promotionPrice != null) {
                                priceToPost = item.promotionPrice!;
                              }
                              cartController.toggleCart(
                                item.id,
                                {}.toString(),
                                item.product.id,
                                item.product.name,
                                priceToPost.toString(),
                                item.product.image,
                                {},
                              );
                            }
                          },
                          child: IntrinsicHeight(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade400)
                                ],
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: Colors.grey.shade100),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.favorite_border),
                                            Icon(Icons.info_outline),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (item.promotionPrice == null)
                                                Text(
                                                  '\AED ${item.product.price}',
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              else
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '\AED ${item.product.price}',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\AED ${item.promotionPrice}',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              Obx(() {
                                                final isInLocalCart =
                                                    cartController.isInCart(
                                                        item.product.id);
                                                final isInServerCart =
                                                    cartController
                                                        .fetchedcartItems
                                                        .any((fetchedItem) =>
                                                            fetchedItem[
                                                                'product_id'] ==
                                                            item.product.id);

                                                final isInCart =
                                                    isInLocalCart ||
                                                        isInServerCart;
                                                double priceToPost =
                                                    item.product.price;
                                                if (item.promotionPrice !=
                                                    null) {
                                                  priceToPost =
                                                      item.promotionPrice!;
                                                }
                                                return GestureDetector(
                                                  onTap: isInCart
                                                      ? null
                                                      : () {
                                                          cartController
                                                              .toggleCart(
                                                            item.id,
                                                            {}.toString(),
                                                            item.product.id,
                                                            item.product.name,
                                                            priceToPost
                                                                .toString(),
                                                            item.product.image,
                                                            {},
                                                          );
                                                        },
                                                  child: Icon(
                                                    isInCart
                                                        ? Icons.shopping_cart
                                                        : Icons
                                                            .shopping_cart_outlined,
                                                    color: isInCart
                                                        ? Color(0xFFEB1C23)
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
                                  Obx(() {
                                    final quantity =
                                        quantityMap[item.product.id]!
                                            .value; // Use .value for RxInt
                                    return isSelected.value
                                        ? Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.r),
                                                      color: Colors.white,
                                                    ),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: (quantity) > 1
                                                            ? Colors
                                                                .red.shade600
                                                            : Colors.grey,
                                                      ),
                                                      onPressed: () {
                                                        if (quantity > 1) {
                                                          // Reduce the quantity by 1
                                                          cartController
                                                              .updateQuantity(
                                                                  item.product
                                                                      .id,
                                                                  -1);
                                                          quantityMap[item.product
                                                                      .id]!
                                                                  .value =
                                                              quantity -
                                                                  1; // Update using .value
                                                        } else {
                                                          // If quantity is 1, remove the item from the cart
                                                          final productId =
                                                              item.product.id;
                                                          if (token != null) {
                                                            cartController
                                                                .removeItemFromCart(
                                                                    productId);
                                                            isSelected.value = false;
                                                          } else {
                                                            cartController
                                                                .removeFromCart(
                                                              item.product.name,
                                                              (item.product
                                                                          .price ??
                                                                      0)
                                                                  .toString(),
                                                              item.product
                                                                  .image,
                                                              item.product.id
                                                                  as String,
                                                            );
                                                            isSelected.value = false;

                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                    '$quantity',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.r),
                                                      color: Colors.white,
                                                    ),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors
                                                            .green.shade800,
                                                      ),
                                                      onPressed: () {
                                                        cartController
                                                            .updateQuantity(
                                                                item.product.id,
                                                                1);
                                                        quantityMap[
                                                                    item.product
                                                                        .id]!
                                                                .value =
                                                            quantity +
                                                                1; // Update using .value
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
                          ));
                    },
                  ),
                );
              }
            },
          ),
        ));
  }
}
