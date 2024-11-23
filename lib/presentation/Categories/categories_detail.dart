import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/apiClient/api.dart';
import '../../data/models/models.dart';
import '../Cart/cart_controller.dart';
import '../Products/products_controller.dart';
import '../favorite/fav_controller.dart';
import '../organic/organic_page.dart';

class DetailPage extends StatelessWidget {
  final String categoryId;
  Map<int, List<int>> selectedServices = {};
  final String categoryName;
  final ProductsController productController = Get.put(ProductsController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  GetStorage Box = GetStorage();
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
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                appBar: AppBar(
                  leading:  IconButton(
                    icon: Container(
                      height: 22.h,width: 26.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r)
                        ),
                        child: Center(child: Icon(Icons.arrow_back_ios_rounded,color:Color(0xFFEB1C23),size: 20.sp,))),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text(categoryName, style: TextStyle(color: Colors.white)),
                  backgroundColor: Color(0xFFEB1C23),
                  bottom: TabBar(labelStyle: TextStyle(color: Colors.black),isScrollable: true,
                    tabs: [
                      Tab(text: "",),
                      ...subcategories.map((subcategory) => Tab(text: subcategory.product.name,)).toList(),
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
                                  crossAxisCount: Box.read('selectedButton') == 'laundry' ? 2 : 2,
                                  crossAxisSpacing: 12.0,
                                  mainAxisSpacing: 20.0,
                                  mainAxisExtent: Box.read('selectedButton') == 'laundry' ? 284 : 200,
                                ),
                                itemCount: productController.productItems.length,
                                itemBuilder: (context, index) {
                                  final item = productController.productItems[index];
                                  Map<int, Map<String, dynamic>> selectedServices = {};
                                  return Column(
                                    children: [
                                      IntrinsicHeight(
                                        child: IntrinsicWidth(
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
                                                  child: item.product.image.isNotEmpty
                                                      ? Image.network(
                                                    '${Api.ImageUrl}/products/${item.product.image}',
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
                                                  item.product.name,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                // Use SingleChildScrollView to avoid overflow
                                                Box.read('selectedButton') == 'laundry'
                                                    ? SingleChildScrollView(
                                                  child:Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                                    child: Column(
                                                      children: item.services.map((service) {
                                                        return Obx(() {
                                                          bool isSelected = productController.selectedServices[item.id]?.contains(service.id) ?? false;
                                                          return GestureDetector(
                                                            onTap: () {
                                                              bool newValue = !isSelected;
                                                              productController.toggleServiceSelection(item.id, service.id, newValue);
                                                              if (newValue) {
                                                                selectedServices[service.id] = {
                                                                  'name': service.name,
                                                                  'price': service.pivot.price,
                                                                };
                                                              } else {
                                                                selectedServices.remove(service.id);
                                                              }
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures space between elements
                                                              crossAxisAlignment: CrossAxisAlignment.center, // Aligns everything at the center vertically
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric( vertical: 4.h),
                                                                  child: AnimatedContainer(
                                                                    duration: Duration(milliseconds: 300),
                                                                    width: 30.w,
                                                                    height: 14.h,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(8.r),
                                                                      color: isSelected ? Colors.green : Colors.grey.shade200,
                                                                      border: Border.all(color: Colors.grey.shade300),
                                                                    ),
                                                                    child: Align(
                                                                      alignment: isSelected ? Alignment.centerRight : Alignment.centerLeft,
                                                                      child: Padding(
                                                                        padding: EdgeInsets.all(2),
                                                                        child: AnimatedContainer(
                                                                          duration: Duration(milliseconds: 300),
                                                                          width: 11.w,
                                                                          height: 10.h,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              SizedBox(width: 7.w,),
                                                                Expanded(
                                                                  child: Text(
                                                                    service.name,
                                                                    style: TextStyle(
                                                                      fontSize: 12.sp,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.grey.shade600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "\$${service.pivot.price}",
                                                                  style: TextStyle(
                                                                    fontSize: 12.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.grey.shade600,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                          );
                                                        });
                                                      }).toList(),
                                                    ),
                                                  ),



                                                )
                                                    : SizedBox.shrink(),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Box.read('selectedButton') == 'laundry'
                                                     ? Obx(() {
                                                        // Calculate the total price based on selected services
                                                        final totalPrice =
                                                        productController.calculateTotalPrice(item);
                                                        print(totalPrice);
                                                        return Text(
                                                          '\$${totalPrice}',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        );
                                                      }):
                                                      (item.promotionPrice == null
                                                      // Display the regular price if no promotion price
                                                          ? Text(
                                                        '\AED${item.price}',
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
                                                      )),

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
                                                              item.productId,
                                                              item.product.name,
                                                              priceToPost,
                                                              item.product.image,
                                                              selectedServices,
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
            ),
          );
        }
      },
    );
  }
}
