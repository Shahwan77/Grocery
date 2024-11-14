import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/apiClient/api.dart';
import '../../data/models/models.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
import '../home_screen/page/home_page.dart';
import 'package:http/http.dart' as http;
class SearchPage extends StatelessWidget {
  final TextEditingController searchTextController = TextEditingController();
  final SearchController searchController = Get.put(SearchController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
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
        title: Text("Search Products",style: TextStyle(color: Colors.white),),      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchTextController,
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
                    String query = searchTextController.text.trim();
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
                                  '${Api.ImageUrl}/products/${product.image}',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    product.name,
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
                      
                                    Text(
                                      '\$${product.price}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
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
                                              product.price as String,
                                              product.image,
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
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
class SearchController extends GetxController {
  var isLoading = false.obs;
  var popularProducts = <Models>[].obs;

  Future<void> searchProducts(String query) async {
    isLoading.value = true;
    String Type = GetStorage().read('selectedButton')??'grocery';
    final String? selectedShopId = GetStorage().read('selected_shop_id');

    final url = 'https://grocery-dev.greendomains.in/api/products/search?shop_id=$selectedShopId&type=$Type&name=$query';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          var products = data['data'] as List;
          popularProducts.value = products.map((product) => Models.fromJson(product)).toList();
        }
      } else {
        Get.snackbar("Error", "Failed to fetch products");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}

class Product {
  final int id;
  final String name;
  final String type;
  final String image;
  final double price;

  Product({required this.id, required this.name, required this.type, required this.image, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      image: json['image'],
      price: json['price'] is String
          ? double.parse(json['price'])
          : json['price'].toDouble(),
    );
  }
}
