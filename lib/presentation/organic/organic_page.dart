import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/apiClient/api.dart';
import '../../data/models/models.dart';
import '../Cart/cart_controller.dart';
import '../Products/products_controller.dart';
import 'all_organic_food.dart';

// class OrganicPage extends StatelessWidget {
//
//   final CartController cartController = Get.put(CartController());
//   final ProductsController productsController = Get.put(ProductsController());
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     int categoryId = 2;
//     return FutureBuilder<List<Models>>(
//       future: productsController.fetchSubcategories(categoryId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }  else {
//           final subcategories = snapshot.data!;
//
//           return DefaultTabController(
//             length: subcategories.length + 1,
//             child: Scaffold(
//               backgroundColor: Colors.white,
//               appBar: AppBar(
//                 iconTheme: IconThemeData(color: Colors.white),
//                 backgroundColor: Colors.red,
//                 title: Text('ORGANIC & HEALTHY FOOD', style: TextStyle(color: Colors.white)),
//               ),
//               body: Column(
//                 children: [
//                   Container(
//                     color: Colors.white,
//                     child: TabBar(
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicatorColor: Colors.red,
//                       unselectedLabelColor: Colors.grey,
//                       labelStyle: TextStyle(color: Colors.black),
//                       labelPadding: EdgeInsets.all(8),
//                       isScrollable: true,
//                       tabs: [
//                         Tab(text: 'All'),
//                         ...subcategories.map((subcategory) => Tab(text: subcategory.name)).toList(),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         AllOrganicFood(),
//                         ...subcategories.map((subcategory) {
//                           return SubcategoryPage(subcategory: subcategory);
//                         }).toList(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class SubcategoryPage extends StatelessWidget {
  final Models subcategory;

  SubcategoryPage({required this.subcategory});
  final ProductsController productsController = Get.put(ProductsController());
  final CartController cartController = Get.put(CartController());


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Models>>(
      future: productsController.fetchTabs(subcategory.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available for ${subcategory.name}'));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20.0,
              mainAxisExtent: 194,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Column(
                children: [
                  IntrinsicHeight(
                    child: Container(
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
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
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.green.shade800,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: product.image.isNotEmpty
                                ? Image.network(
                              'https://grocery-dev.greendomains.in/storage/images/products/${product.image}',
                              fit: BoxFit.cover,
                              height: 80.h,
                              width: 80.w,
                            )
                                : Icon(
                              Icons.image,
                              size: 80.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 6.w),
                            child: Text(
                              product.name,
                              style: TextStyle(fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.price.isNotEmpty ? product.price : '00',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Obx(() {
                                  final isInLocalCart = cartController.isInCart(product.id);
                                  final isInServerCart = cartController.fetchedcartItems
                                      .any((fetchedItem) => fetchedItem['product_id'] == product.id);

                                  final isInCart = isInLocalCart || isInServerCart; // Check if item is in local or server cart

                                  return GestureDetector(
                                    onTap: isInCart // Disable onTap if already in cart
                                        ? null // Disable the action if item is already in the cart
                                        : () {
                                      cartController.toggleCart(
                                        product.id, // Product ID
                                        product.name,
                                        product.price,
                                        product.image,[]
                                      );

                                      Get.snackbar(
                                        cartController.isInCart(product.id)
                                            ? 'Added to Cart'
                                            : 'Removed from Cart',
                                        '${product.name} has been ${cartController.isInCart(product.id) ? 'added to' : 'removed from'} your cart.',
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    },
                                    child: Icon(
                                      isInCart
                                          ? Icons.shopping_cart // Show filled cart if item is in cart
                                          : Icons.shopping_cart_outlined, // Show empty cart if item is not in cart
                                      color: isInCart ? Colors.green : Colors.grey, // Change icon color
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
      },
    );
  }
}
