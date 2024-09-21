// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import '../../data/apiClient/api.dart';
// import '../../widgets/button/button.dart';
// import '../bottomnav/controller/bottomnav_controller.dart';
// import 'cart_controller.dart';
//
// class CartPage extends StatelessWidget {
//   final CartController cartController = Get.put(CartController());
//   final BottomNavController bottomNavController = Get.put(BottomNavController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text(
//           'Cart',
//           style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.white),
//         ),
//         backgroundColor: Colors.green.shade800,
//       ),
//       body: Obx(() {
//         if (cartController.cartItems.isEmpty) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Lottie.asset('assets/Animation - 1724233631425.json'),
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 'Your Cart is empty!',
//                 style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 20.h),
//               Button(
//                 size: Size(164, 54),
//                 color: Colors.green.shade800,
//                 text: Text(
//                   'Start Shopping',
//                   style: TextStyle(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white),
//                 ),
//                 ontap: () {
//                   // Navigate to products page
//                 },
//               )
//             ],
//           );
//         }
//         return SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 itemCount: cartController.getCartItems().length,
//                 itemBuilder: (context, index) {
//                   final item = cartController.getCartItems()[index];
//                   // final int quantity = item['quantity'] ?? 1; // Default to 1
//                   final int? productId = item['product_id'];
//                   return Container(
//                     height: 114.h,
//                     margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: Row(
//                       children: [
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Container(
//                               height: 100.h,
//                               width: 100.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 color: Colors.white,
//                               ),
//                               child: Center(
//                                 child: Image.network(
//                                   '${Api.ImageUrl}/products/${item['image']}',
//                                   width: 80.w,
//                                   height: 80.h,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 70.h,
//                               right: 34.w,
//                               left: 35,
//                               child: Container(
//                                 height: 30.h,
//                                 width: 34.w,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade200,
//                                   borderRadius: BorderRadius.only(
//                                     bottomRight: Radius.circular(14.r),
//                                     bottomLeft: Radius.circular(14.r),
//                                   ),
//                                 ),
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/dlt.png',
//                                     width: 20.w,
//                                     height: 20.h,
//                                     color: Colors.red.shade600,
//                                   ),
//                                   onPressed: () {
//                                     cartController.removeFromCart(productId!);
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(width: 10.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item['name'],
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                               Spacer(),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     item['price'],
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14.sp,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           height: 30.h,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10.r),
//                                             color: Colors.white,
//                                           ),
//                                           child: IconButton(
//                                             icon: Icon(
//                                               Icons.remove,
//                                               color: item['quantity'] > 1
//                                                   ? Colors.red.shade600
//                                                   : Colors.grey,
//                                             ),
//                                             onPressed: () {
//                                               if (item['quantity'] > 1) {
//                                                 cartController.updateQuantity(
//                                                     item['name'], -1);
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                         SizedBox(width: 5.w),
//                                         Text(
//                                           '${item['quantity']}',
//                                           style: GoogleFonts.roboto(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14.sp,
//                                           ),
//                                         ),
//                                         SizedBox(width: 5.w),
//                                         Container(
//                                           height: 30.h,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10.r),
//                                             color: Colors.white,
//                                           ),
//                                           child: IconButton(
//                                             icon: Icon(
//                                               Icons.add,
//                                               color: item['quantity'] > 1
//                                                   ? Colors.green.shade800
//                                                   : Colors.grey,
//                                             ),
//                                             onPressed: () {
//                                               cartController.updateQuantity(
//                                                   item['name'], 1);
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20.h),
//               SizedBox(height: 20.h),
//               Button(
//                 size: Size(164, 54),
//                 color: Colors.green.shade800,
//                 text: Text(
//                   'Checkout',
//                   style: TextStyle(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white),
//                 ),
//                 ontap: () {
//                   // Navigate to checkout page
//                 },
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }






import 'package:flutter/material.dart';

class PostedItemsPage extends StatelessWidget {
  final dynamic postedItems;

  PostedItemsPage({required this.postedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posted Items'),
      ),
      body: ListView.builder(
        itemCount: postedItems['data'].length, // Adjust based on your API response
        itemBuilder: (context, index) {
          final item = postedItems['data'][index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('Quantity: ${item['quantity']}'),
          );
        },
      ),
    );
  }
}







// Button(
// color: Colors.green.shade800,
// size: Size(340.w, 45.h),
// text: Text(
// "Continue",
// style: TextStyle(fontSize: 18.sp, color: Colors.white),
// ),
// ontap: () async {
// if (!cartController.isLoggedIn()) {
// await Get.to(() => LoginPage());
// } else {
// // Navigate directly to PostedItemsPage if already logged in
// await cartController.postCartItems();
// }
// },
// ),



// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class CartController extends GetxController {
//   var cartItems = <Map<String, dynamic>>[].obs;
//   var products = <Map<String, dynamic>>[].obs; // To store product data from API
//
//   final box = GetStorage();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadCartItems();
//     fetchProducts();
//
//   }
//
//   void loadCartItems() {
//     final savedCart = box.read('cartItems');
//     if (savedCart != null) {
//       cartItems.assignAll(List<Map<String, dynamic>>.from(savedCart));
//     }
//   }
//
//   void saveCartItems() {
//     box.write('cartItems', cartItems);
//     printStoredItems();
//   }
//
//   int get uniqueItemCount => cartItems.length;
//
//   int get itemCount => cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
//
//   // Fetch products from the API
//   Future<void> fetchProducts() async {
//     try {
//       final response = await http.get(Uri.parse('https://grocery-dev.greendomains.in/api/products'));
//       if (response.statusCode == 200) {
//         products.assignAll(List<Map<String, dynamic>>.from(json.decode(response.body)));
//       } else {
//         print('Failed to load products');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   // Add/remove product based on product_id
//   void toggleCart(int productId, String itemName, String itemPrice, String itemImage) {
//     final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
//     if (itemIndex >= 0) {
//       cartItems.removeAt(itemIndex);
//     } else {
//       cartItems.add({
//         'product_id': productId,
//         'name': itemName,
//         'price': itemPrice,
//         'image': itemImage,
//         'quantity': 1,
//       });
//     }
//     saveCartItems();
//   }
//
//   void updateQuantity(int productId, int change) {
//     final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
//     if (itemIndex >= 0) {
//       cartItems[itemIndex]['quantity'] += change;
//
//       if (cartItems[itemIndex]['quantity'] <= 0) {
//         cartItems.removeAt(itemIndex);
//       } else {
//         cartItems.refresh();
//       }
//       saveCartItems();
//     }
//   }
//
//   bool isInCart(int productId) {
//     return cartItems.any((item) => item['product_id'] == productId);
//   }
//
//   List<Map<String, dynamic>> getCartItems() {
//     return cartItems;
//   }
//
//   void removeFromCart(int productId) {
//     final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
//     if (itemIndex >= 0) {
//       cartItems.removeAt(itemIndex);
//       saveCartItems();
//     }
//   }
//
//   void printStoredItems() {
//     final storedItems = box.read('cartItems');
//     if (storedItems != null && storedItems.isNotEmpty) {
//       print('Stored Cart Items: $storedItems');
//       print('Total number of items in cart: ${cartItems.length}');
//     } else {
//       print('No items found in local storage.');
//     }
//   }
// }
