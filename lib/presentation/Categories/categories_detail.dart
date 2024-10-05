import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/apiClient/api.dart';
import '../../data/models/models.dart';
import '../Cart/cart_controller.dart';
import '../Products/products_controller.dart';
import '../favorite/fav_controller.dart';
import '../organic/organic_page.dart';

class DetailPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final ProductsController productController = Get.put(ProductsController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  DetailPage({required this.categoryId, required this.categoryName,});

  Future<List<Models>> _fetchSubcategories() async {
    return await productController.fetchSubcategories(int.parse(categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Models>>(
      future: _fetchSubcategories(), // Fetch subcategories here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final subcategories = snapshot.data!;
          return DefaultTabController(
            length: subcategories.length +1, // +2 for Products and Favorites
            child: Scaffold(
              appBar: AppBar(
                leading:  IconButton(
                  icon: Container(
                    height: 22.h,width: 26.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r)
                      ),
                      child: Center(child: Icon(Icons.arrow_back_ios_rounded,color: Colors.red,size: 20.sp,))),
                  onPressed: () {
                    Get.back();
                  },
                ),
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(categoryName, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red,
                bottom: TabBar(labelStyle: TextStyle(color: Colors.black),isScrollable: true,
                  tabs: [
                    Tab(text: "",),
                    ...subcategories.map((subcategory) => Tab(text: subcategory.name,)).toList(),
                    //Tab(text: 'Favorites'), // Add favorites tab
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              body: TabBarView(
                children: [
                  FutureBuilder(
                    future: productController.fetchProducts(int.parse(categoryId)), // Fetch products based on categoryId
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else {
                        return Obx(() {
                          if (productController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          } else if (productController.productItems.isEmpty) {
                            return Center(child: Text("No products found."));
                          } else {
                            return GridView.builder(
                              padding: EdgeInsets.all(8.0),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 20.0,
                                mainAxisExtent: 200,
                              ),
                              itemCount: productController.productItems.length,
                              itemBuilder: (context, index) {
                                final item = productController.productItems[index];
                                return Column(
                                  children: [
                                    IntrinsicHeight(
                                      child: Container(
                                        width: 160.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8.r),
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
                                                          snackPosition: SnackPosition.BOTTOM,
                                                        );
                                                      },
                                                      child: Icon(
                                                        favoriteController.isFavorite(item.name)
                                                            ? Icons.favorite
                                                            : Icons.favorite_border,
                                                        color: favoriteController.isFavorite(item.name)
                                                            ? Colors.red
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
                                              child: item.image.isNotEmpty
                                                  ? Image.network(
                                                '${Api.ImageUrl}/products/${item.image}',
                                                fit: BoxFit.cover,
                                                height: 80.h,
                                                width: 80.w,
                                                errorBuilder: (context, error, stackTrace) => Icon(
                                                  Icons.hide_image_outlined,
                                                  size: 90.sp,
                                                  color: Colors.grey,
                                                ),
                                              )
                                                  : Icon(
                                                Icons.hide_image_outlined,
                                                size: 90.sp,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              item.name,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    item.price,
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
                                                          ? null // Disable the action if item is already in the cart
                                                          : () {
                                                        cartController.toggleCart(
                                                          item.id,
                                                          item.name,
                                                          item.price,
                                                          item.image,
                                                        );

                                                        Get.snackbar(
                                                          cartController.isInCart(item.id)
                                                              ? 'Added to Cart'
                                                              : 'Removed from Cart',
                                                          '${item.name} has been ${cartController.isInCart(item.id) ? 'added to' : 'removed from'} your cart.',
                                                          snackPosition: SnackPosition.TOP,
                                                        );
                                                      },
                                                      child: Icon(
                                                        isInCart
                                                            ? Icons.shopping_cart // Show filled cart if item is in cart
                                                            : Icons.shopping_cart_outlined, // Show empty cart if item is not in cart
                                                        color: isInCart ? Colors.red : Colors.grey,
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
                        });
                      }
                    },
                  ),
                  // Create a SubcategoryPage for each subcategory
                  ...subcategories.map((subcategory) => SubcategoryPage(subcategory: subcategory)).toList(),
                  // Placeholder for Favorites Tab
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
