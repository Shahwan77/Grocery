import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Search/search_controller.dart';
import '../../data/apiClient/api.dart';
import '../../data/models/models.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
import '../home_screen/page/home_page.dart';
import 'package:http/http.dart' as http;
class SearchPage extends StatelessWidget {

  final String query; // Received from HomePage


  SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchPoductController searchController = Get.put(SearchPoductController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    final CartController cartController = Get.put(CartController());
    final token = GetStorage().read('access_token');
    Map<int, RxInt> quantityMap = {};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.searchProducts(query);
    });

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
                height: 22.h, width: 26.w,
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
          title: Text("Search Products",style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController.searchTextController,
                decoration: InputDecoration(
                  hintText: languagecontroller.searchText,
                  hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search,color: Color(0xFFEB1C23)),
                    onPressed: () {
                      String query = searchController.searchTextController.text.trim();
                      if (query.isNotEmpty) {
                        searchController.searchProducts(query);
                      }
                    },
                  ),
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 15.w,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(() {
                if (searchController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (searchController.popularProducts.isEmpty) {
                  return Center(child: Text("No products found"));
                }
                return Expanded(
                  child: GridView.builder(
                    itemCount: searchController.popularProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      mainAxisExtent: GetStorage().read('selectedButton') == 'laundry' ? 220.h : 176.h,
                    ),
                    itemBuilder: (context, index) {
                      final product = searchController.popularProducts[index];
                      RxBool isSelected = false.obs;
                      quantityMap.putIfAbsent(product.product.id, () => 1.obs);
                      return GestureDetector(
                        onTap: () {
                          isSelected.value = !isSelected.value;
                          if (isSelected.value) {
                            String priceToPost = product.price.toString();
                            if (product.promotionPrice != null) {
                              priceToPost = product.promotionPrice.toString(); // Use promotionPrice if it's not null
                            }
                            cartController.toggleCart(
                                null,
                                {}.toString(),
                                product.productId,
                                product.product.name,
                                priceToPost,
                                product.product.image,
                                {}
                            );
                          }// Toggle the selected state
                        },
                        child: IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.grey.shade400)],
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
                                        '${Api.ImageUrl}/products/${product.product.image}',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          product.product.name,
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
                                          (product.promotionPrice == null
                                          // Display the regular price if no promotion price
                                              ? Text(
                                            '\AED${product.price}',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                          // If promotion price is not null, show both prices
                                              : Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '\AED${product.price}',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              Text(
                                                '\AED${product.promotionPrice}',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          )),
                                          Obx(() {
                                            final isInLocalCart = cartController.isInCart(product.productId);
                                            final isInServerCart = cartController.fetchedcartItems
                                                .any((fetchedItem) => fetchedItem['product_id'] == product.productId);

                                            final isInCart = isInLocalCart || isInServerCart;
                                            String priceToPost = product.price.toString();
                                            if (product.promotionPrice != null) {
                                              priceToPost = product.promotionPrice.toString(); // Use promotionPrice if it's not null
                                            }
                                            return GestureDetector(
                                              onTap: isInCart ? null : () {
                                                cartController.toggleCart(
                                                    null,
                                                    {}.toString(),
                                                    product.productId,
                                                    product.product.name,
                                                    priceToPost,
                                                    product.product.image,
                                                    {}
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
                            final quantity = quantityMap[product.product.id]!.value; // Ensure quantity has a default value
                                    return isSelected.value
                                        ? Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(15.r),
                                        ),
                                        child:  Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(14.r),
                                                color: Colors.white,
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                ),
                                                onPressed: () {
                                                  if (quantity > 1) {
                                                    cartController
                                                        .updateQuantity(
                                                        product.product.id,
                                                        -1);
                                                    quantityMap[product
                                                        .product.id]!
                                                        .value =
                                                        quantity -
                                                            1; // Update using .value
                                                  } else if (quantity == 1) {
                                                    final productId =
                                                        product.product.id;
                                                    if (token != null) {
                                                      cartController
                                                          .removeItemFromCart(
                                                          productId);
                                                    } else {
                                                      cartController
                                                          .removeFromCart(
                                                        product.product.name,
                                                        (product.product.price ??
                                                            0)
                                                            .toString(),
                                                        product.product.image,
                                                        product.product.type,
                                                      );
                                                    }
                                                    quantityMap[product
                                                        .product.id]!
                                                        .value =
                                                    0; // Set quantity to 0 after removal
                                                  }
                                                },
                                              ),
                                            ),
                                            Text(
                                              '$quantity',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(14.r),
                                                color: Colors.white,
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.green.shade800,
                                                ),
                                                onPressed: () {
                                                  if (quantity == 0) {
                                                    quantityMap[product
                                                        .product.id]!
                                                        .value =
                                                    1; // Set to 1 if it was 0
                                                    cartController.toggleCart(
                                                      product.product.id,
                                                      {}.toString(),
                                                      product.product.id,
                                                      product.product.name,
                                                      product.price.toString(),
                                                      product.product.image,
                                                      {},
                                                    );
                                                  } else {
                                                    cartController
                                                        .updateQuantity(
                                                        product.product.id, 1);
                                                    quantityMap[product
                                                        .product.id]!
                                                        .value =
                                                        quantity +
                                                            1; // Increment quantity
                                                  }
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
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

