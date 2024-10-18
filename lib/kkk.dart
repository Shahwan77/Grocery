// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../data/apiClient/api.dart';
// import '../../data/models/models.dart';
// import '../Cart/cart_controller.dart';
// import '../Products/products_controller.dart';
// import '../favorite/fav_controller.dart';
// import '../organic/organic_page.dart';
//
// class DetailPage extends StatelessWidget {
//   final String categoryId;
//   final String categoryName;
//   final ProductsController productController = Get.put(ProductsController());
//   final CartController cartController = Get.put(CartController());
//   final FavoriteController favoriteController = Get.put(FavoriteController());
//   GetStorage Box = GetStorage();
//
//   DetailPage({required this.categoryId, required this.categoryName,});
//
//   Future<List<Models>> _fetchSubcategories() async {
//     return await productController.fetchSubcategories(int.parse(categoryId));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Models>>(
//       future: _fetchSubcategories(), // Fetch subcategories here
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error}"));
//         } else {
//           final subcategories = snapshot.data!;
//           return DefaultTabController(
//             length: subcategories.length + 1,
//             child: Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                   icon: Container(
//                     height: 22.h,
//                     width: 26.w,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30.r),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         Icons.arrow_back_ios_rounded,
//                         color: Color(0xFFEB1C23),
//                         size: 20.sp,
//                       ),
//                     ),
//                   ),
//                   onPressed: () {
//                     Get.back();
//                   },
//                 ),
//                 iconTheme: IconThemeData(color: Colors.white),
//                 title: Text(categoryName, style: TextStyle(color: Colors.white)),
//                 backgroundColor: Color(0xFFEB1C23),
//                 bottom: TabBar(
//                   labelStyle: TextStyle(color: Colors.black),
//                   isScrollable: true,
//                   tabs: [
//                     Tab(text: ""),
//                     ...subcategories.map((subcategory) => Tab(text: subcategory.name)).toList(),
//                   ],
//                 ),
//               ),
//               backgroundColor: Colors.white,
//               body: TabBarView(
//                 children: [
//                   FutureBuilder(
//                     future: productController.fetchProducts(int.parse(categoryId)), // Fetch products based on categoryId
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(child: Text("Error: ${snapshot.error}"));
//                       } else {
//                         return Obx(() {
//                           if (productController.isLoading.value) {
//                             return Center(child: CircularProgressIndicator());
//                           } else if (productController.productItems.isEmpty) {
//                             return Center(child: Text("No products found."));
//                           } else {
//                             return GridView.builder(
//                               padding: EdgeInsets.all(8.0),
//                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10.0,
//                                 mainAxisSpacing: 20.0,
//                                 mainAxisExtent: 200,
//                               ),
//                               itemCount: productController.productItems.length,
//                               itemBuilder: (context, index) {
//                                 final item = productController.productItems[index];
//
//                                 // Initialize a list to store selected services
//                                 List<String> selectedServices = [];
//
//                                 return Column(
//                                   children: [
//                                     IntrinsicHeight(
//                                       child: IntrinsicWidth(
//                                         child: Container(
//                                           width: 160.w,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(8.r),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black26,
//                                                 blurRadius: 4.0,
//                                                 offset: Offset(0, 2),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Obx(() {
//                                                       return GestureDetector(
//                                                         onTap: () {
//                                                           final itemData = {
//                                                             'name': item.name,
//                                                             'price': item.price,
//                                                             'image': item.image,
//                                                           };
//
//                                                           favoriteController.toggleFavorite(
//                                                             itemData['name']!,
//                                                             itemData['price']!,
//                                                             itemData['image']!,
//                                                           );
//
//                                                           Get.snackbar(
//                                                             favoriteController.isFavorite(itemData['name']!)
//                                                                 ? 'Added to Favorites'
//                                                                 : 'Removed from Favorites',
//                                                             '${itemData['name']} has been ${favoriteController.isFavorite(itemData['name']!) ? 'added to' : 'removed from'} your favorites.',
//                                                             snackPosition: SnackPosition.BOTTOM,
//                                                           );
//                                                         },
//                                                         child: Icon(
//                                                           favoriteController.isFavorite(item.name)
//                                                               ? Icons.favorite
//                                                               : Icons.favorite_border,
//                                                           color: favoriteController.isFavorite(item.name)
//                                                               ? Color(0xFFEB1C23)
//                                                               : Colors.grey,
//                                                         ),
//                                                       );
//                                                     }),
//                                                     Icon(
//                                                       Icons.info_outline,
//                                                       color: Colors.green.shade800,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Box.read('selectedButton') == 'laundry'
//                                                   ? Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Obx(() => Column(
//                                                     children: [
//                                                       Icon(Icons.dry_cleaning_outlined),
//                                                       Text('DRYCLEAN', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
//                                                       Checkbox(
//                                                         value: cartController.isCheckedList[0].value,
//                                                         onChanged: (value) {
//                                                           cartController.toggleCheckbox(0, value);
//                                                           if (value!) {
//                                                             selectedServices.add('DRYCLEAN');
//                                                           } else {
//                                                             selectedServices.remove('DRYCLEAN');
//                                                           }
//                                                         },
//                                                       ),
//                                                     ],
//                                                   )),
//                                                   Obx(() => Column(
//                                                     children: [
//                                                       Icon(Icons.wash_outlined),
//                                                       Text('WASH', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
//                                                       Checkbox(
//                                                         value: cartController.isCheckedList[1].value,
//                                                         onChanged: (value) {
//                                                           cartController.toggleCheckbox(1, value);
//                                                           if (value!) {
//                                                             selectedServices.add('WASH');
//                                                           } else {
//                                                             selectedServices.remove('WASH');
//                                                           }
//                                                         },
//                                                       ),
//                                                     ],
//                                                   )),
//                                                   Obx(() => Column(
//                                                     children: [
//                                                       Icon(Icons.iron_outlined),
//                                                       Text('IRON', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
//                                                       Checkbox(
//                                                         value: cartController.isCheckedList[2].value,
//                                                         onChanged: (value) {
//                                                           cartController.toggleCheckbox(2, value);
//                                                           if (value!) {
//                                                             selectedServices.add('IRON');
//                                                           } else {
//                                                             selectedServices.remove('IRON');
//                                                           }
//                                                         },
//                                                       ),
//                                                     ],
//                                                   )),
//                                                 ],
//                                               )
//                                                   : SizedBox.shrink(),
//                                               Center(
//                                                 child: item.image.isNotEmpty
//                                                     ? Image.network(
//                                                   '${Api.ImageUrl}/products/${item.image}',
//                                                   fit: BoxFit.cover,
//                                                   height: 80.h,
//                                                   width: 80.w,
//                                                   errorBuilder: (context, error, stackTrace) =>
//                                                       Icon(Icons.hide_image_outlined, size: 90.sp, color: Colors.grey),
//                                                 )
//                                                     : Icon(Icons.hide_image_outlined, size: 90.sp, color: Colors.grey),
//                                               ),
//                                               Text(
//                                                 item.name,
//                                                 style: TextStyle(
//                                                   fontSize: 12.sp,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                                 textAlign: TextAlign.center,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       item.price,
//                                                       style: TextStyle(
//                                                         fontSize: 12.sp,
//                                                         fontWeight: FontWeight.w700,
//                                                       ),
//                                                     ),
//                                                     Obx(() {
//                                                       final isInLocalCart = cartController.isInCart(item.id);
//                                                       final isInServerCart = cartController.fetchedcartItems
//                                                           .any((fetchedItem) => fetchedItem['product_id'] == item.id);
//
//                                                       final isInCart = isInLocalCart || isInServerCart;
//
//                                                       return GestureDetector(
//                                                         onTap: isInCart
//                                                             ? null // Disable the action if item is already in the cart
//                                                             : () {
//                                                           // Pass the selected services along with item details
//                                                           cartController.toggleCart(
//                                                             item.id,
//                                                             item.name,
//                                                             item.price,
//                                                             item.image,
//                                                             selectedServices, // Pass selected services here
//                                                           );
//
//                                                           Get.snackbar(
//                                                             cartController.isInCart(item.id) ? 'Added to Cart' : 'Removed from Cart',
//                                                             '${item.name} has been ${cartController.isInCart(item.id) ? 'added to' : 'removed from'} your cart.',
//                                                             snackPosition: SnackPosition.BOTTOM,
//                                                           );
//                                                         },
//                                                         child: Icon(
//                                                           isInCart
//                                                               ? Icons.remove_shopping_cart_outlined
//                                                               : Icons.add_shopping_cart_outlined,
//                                                           color: isInCart ? Color(0xFFEB1C23) : Colors.green.shade800,
//                                                         ),
//                                                       );
//                                                     }),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           }
//                         });
//                       }
//                     },
//                   ),
//                   for (var subcategory in subcategories)
//                     FutureBuilder(
//                       future: productController.fetchProducts(subcategory.id), // Fetch products based on subcategory
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator());
//                         } else if (snapshot.hasError) {
//                           return Center(child: Text("Error: ${snapshot.error}"));
//                         } else {
//                           return Obx(() {
//                             if (productController.isLoading.value) {
//                               return Center(child: CircularProgressIndicator());
//                             } else if (productController.productItems.isEmpty) {
//                               return Center(child: Text("No products found."));
//                             } else {
//                               return GridView.builder(
//                                 padding: EdgeInsets.all(8.0),
//                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   crossAxisSpacing: 10.0,
//                                   mainAxisSpacing: 20.0,
//                                   mainAxisExtent: 200,
//                                 ),
//                                 itemCount: productController.productItems.length,
//                                 itemBuilder: (context, index) {
//                                   final item = productController.productItems[index];
//
//                                   // Initialize a list to store selected services
//                                   List<String> selectedServices = [];
//
//                                   return Column(
//                                     children: [
//                                   IntrinsicHeight(
//                                   child: IntrinsicWidth(
//                                   child: Container(
//                                     width: 160.w,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(8.r),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black26,
//                                           blurRadius: 4.0,
//                                           offset: Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Obx(() {
//                                                 return GestureDetector(
//                                                   onTap: () {
//                                                     final itemData = {
//                                                       'name': item.name,
//                                                       'price': item.price,
//                                                       'image': item.image,
//                                                     };
//
//                                                     favoriteController.toggleFavorite(
//                                                       itemData['name']!,
//                                                       itemData['price']!,
//                                                       itemData['image']!,
//                                                     );
//
//                                                     Get.snackbar(
//                                                       favoriteController.isFavorite(itemData['name']!)
//                                                           ? 'Added to Favorites'
//                                                           : 'Removed from Favorites',
//                                                       '${itemData['name']} has been ${favoriteController.isFavorite(itemData['name']!) ? 'added to' : 'removed from'} your favorites.',
//                                                       snackPosition: SnackPosition.BOTTOM,
//                                                     );
//                                                   },
//                                                   child: Icon(
//                                                     favoriteController.isFavorite(item.name)
//                                                         ? Icons.favorite
//                                                         : Icons.favorite_border,
//                                                     color: favoriteController.isFavorite(item.name)
//                                                         ? Color(0xFFEB1C23)
//                                                         : Colors.grey,
//                                                   ),
//                                                 );
//                                               }),
//                                               Icon(
//                                                 Icons.info_outline,
//                                                 color: Colors.green.shade800,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Box.read('selectedButton') == 'laundry'
//                                             ? Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Obx(() => Column(
//                                               children: [
//                                                 Icon(Icons.dry_cleaning_outlined),
//                                                 Text('DRYCLEAN', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
//                                                 Checkbox(
//                                                   value: cartController.isCheckedList[0].value,
//                                                   onChanged: (value) {
//                                                     cartController.toggleCheckbox(0, value);
//                                                     if (value!) {
//                                                       selectedServices.add('DRYCLEAN');
//                                                     } else {
//                                                       selectedServices.remove('DRYCLEAN');
//                                                     }
//                                                   },
//                                                 ),
//                                               ],
//                                             )),
//                                             Obx(() => Column(
//                                               children: [
//                                                 Icon(Icons.wash_outlined),
//                                                 Text('WASH', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
//                                                 Checkbox(
//                                                   value: cartController.isCheckedList[1].value,
//                                                   onChanged: (value) {
//                                                     cartController.toggleCheckbox(1, value);
//                                                     if (value!) {
//                                                       selectedServices.add('WASH');
//                                                     } else {
//                                                       selectedServices.remove('WASH');
//                                                     }
//                                                   },
//                                                 ),
//                                               ],
//                                             )),
//                                             Obx(() => Column(
//                                               children: [
//                                                 Icon(Icons.iron_outlined),
//                                                 Text('IRON', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
//                                                 Checkbox(
//                                                   value: cartController.isCheckedList[2].value,
//                                                   onChanged: (value) {
//                                                     cartController.toggleCheckbox(2, value);
//                                                     if (value!) {
//                                                       selectedServices.add('IRON');
//                                                     } else {
//                                                       selectedServices.remove('IRON');
//                                                     }
//                                                   },
//                                                 ),
//                                               ],
//                                             )),
//                                           ],
//                                         )
//                                             : SizedBox.shrink(),
//                                         Center(
//                                           child: item.image.isNotEmpty
//                                               ? Image.network(
//                                             '${Api.ImageUrl}/products/${item.image}',
//                                             fit: BoxFit.cover,
//                                             height: 80.h,
//                                             width: 80.w,
//                                             errorBuilder: (context, error, stackTrace) =>
//                                                 Icon(Icons.hide_image_outlined, size: 90.sp, color: Colors.grey),
//                                           )
//                                               : Icon(Icons.hide_image_outlined, size: 90.sp, color: Colors.grey),
//                                         ),
//                                         Text(
//                                           item.name,
//                                           style: TextStyle(
//                                             fontSize: 12.sp,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 item.price,
//                                                 style: TextStyle(
//                                                   fontSize: 12.sp,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                               ),
//                                               Obx(() {
//                                                 final isInLocalCart = cartController.isInCart(item.id);
//                                                 final isInServerCart = cartController.fetchedcartItems
//                                                     .any((fetchedItem) => fetchedItem['product_id'] == item.id);
//
//                                                 final isInCart = isInLocalCart || isInServerCart;
//
//                                                 return GestureDetector(
//                                                   onTap: isInCart
//                                                       ? null // Disable the action if item is already in the cart
//                                                       : () {
//                                                     // Pass the selected services along with item details
//                                                     cartController.toggleCart(
//                                                       item.id,
//                                                       item.name,
//                                                       item.price,
//                                                       item.image,
//                                                       selectedServices, // Pass selected services here
//                                                     );
//
//                                                     Get.snackbar(
//                                                       cartController.isInCart(item.id) ? 'Added to Cart' : 'Removed from Cart',
//                                                       '${item.name} has been ${cartController.isInCart(item.id) ? 'added to' : 'removed from'} your cart.',
//                                                       snackPosition: SnackPosition.BOTTOM,
//                                                     );
//                                                   },
//                                                   child: Icon(
//                                                     isInCart
//                                                         ? Icons.remove_shopping_cart_outlined
//                                                         : Icons.add_shopping_cart_outlined,
//                                                     color: isInCart ? Color(0xFFEB1C23) : Colors.green.shade800,
//                                                   ),
//                                                 );
//                                               }),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                       ],
//                                     ),
//                                   ),
//                                   ),
//                                   ],
//                                   );
//                                 },
//                               );
//                             }
//                           });
//                         }
//                       },
//                     ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
