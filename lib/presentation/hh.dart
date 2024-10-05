// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grocery/widgets/drawer/cus_drawer.dart';
//
// import '../../presentation/Scanner/scanner_page.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double toolbarHeight;
//
//   const CustomAppBar({
//     Key? key,
//     this.toolbarHeight = 100,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: Colors.red,
//         statusBarIconBrightness: Brightness.light,
//       ),
//       surfaceTintColor: Colors.white,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       toolbarHeight: toolbarHeight,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30.r),
//                   color: Colors.grey.shade100,
//                 ),
//                 child: Builder(
//                   builder: (context) {
//                     return IconButton(
//                       icon: SvgPicture.asset(
//                         'assets/menu1.svg',
//                         color: Colors.red,
//                         height: 30,
//                         width: 30,
//                       ),
//                       onPressed: () {
//                         _openCustomDrawer(context);
//                       },
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(width: 5.w),
//               Image.asset(
//                 'assets/logo.png',
//                 height: 40.h,
//                 width: 40.w,
//               ),
//               Icon(
//                 Icons.location_on,
//                 color: Colors.red,
//                 size: 34.sp,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '24 | United Arab Emirates |',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     '13 | 4',
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Column(
//                 children: [
//                   Text(
//                     '0.00',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     'AED',
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 10.h),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search here...',
//                     hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon:
//                     Icon(Icons.search, color: Colors.red),
//                     filled: true,
//                     fillColor: Colors.grey.shade100,
//                     contentPadding: EdgeInsets.symmetric(
//                       vertical: 12.h,
//                       horizontal: 15.w,
//                     ),
//                   ),
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               SizedBox(width: 10.w),
//               InkWell(
//                 onTap: () async {
//                   String? scannedData = await Get.to(() => ScannerPage());
//                   if (scannedData != null) {
//                     print("Scanned data: $scannedData");
//                     // Handle the scanned data here
//                   }
//                 },
//                 borderRadius: BorderRadius.circular(10.r),
//                 child: Container(
//                   height: 46.h,
//                   width: 48.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: Colors.grey.shade100,
//                   ),
//                   child: Icon(
//                     Icons.document_scanner_rounded,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _openCustomDrawer(BuildContext context) {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         opaque: false,
//         pageBuilder: (BuildContext context, _, __) {
//           return CustomDrawerOverlay();
//         },
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(toolbarHeight);
// }
//
// void _openCustomDrawer(BuildContext context) {
//   Navigator.of(context).push(
//     PageRouteBuilder(
//       opaque: false,
//       pageBuilder: (BuildContext context, _, __) {
//         return CustomDrawerOverlay();
//       },
//     ),
//   );
// }
//
// class CustomDrawerOverlay extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).pop(),
//       child: Container(
//         color: Colors.black54, // Background shade
//         child: Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               width: 250.w,
//               child: CusDrawer(), // Your custom drawer widget
//             )
//         ),
//       ),
//     );
//   }
// }
// Future<void> postOrder(List<dynamic> cartItems, String selectedTimeSlot, String selectedDay, int selectedIndex, List<String> cardItems, List<String> paybycashItems) async {
//   final deliveryDay = selectedDay; // Already in "YYYY-MM-DD" format
//   final deliveryTime = selectedTimeSlot; // Format "7:30 AM - 8:30 AM"
//   final paymentMethod = selectedIndex == 0 ? 'cash' : 'card';
//   final change = selectedIndex == 0 ? 500 : null; // Use the selected amount for cash payments
//   final box = GetStorage();
//
//   // Validate cart items
//   if (cartItems.isEmpty) {
//     Get.snackbar('Error', 'Your cart is empty. Please add items to your cart.');
//     return;
//   }
//
//   // Create list of items from cart items
//   try {
//     final itemList = cartItems.map((item) {
//       // Check if item is a Map and contains 'product_id' and 'quantity'
//       if (item is Map<String, dynamic> && item.containsKey('product_id') && item.containsKey('quantity')) {
//         return Item(productId: item['product_id'], quantity: item['quantity']);
//       } else {
//         throw Exception('Invalid cart item structure');
//       }
//     }).toList();
//
//     // Retrieve the access token
//     final String token = box.read('access_token');
//
//     // Create the order
//     final order = Order(
//       delivery: Delivery(
//         date: deliveryDay,
//         timeSlot: deliveryTime,
//       ),
//       payment: Payment(
//         method: paymentMethod,
//         change: change,
//       ),
//       total: Total(
//         count: cartItems.length,
//         amount: double.tryParse(cartController.total_quantity.value) ?? 0.0, // Ensure this is a valid double
//       ),
//       items: itemList,
//     );
//
//     try {
//       // Make the API call
//       final response = await http.post(
//         Uri.parse('https://grocery-dev.greendomains.in/api/order'),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token', // Include the token in the Authorization header
//         },
//         body: jsonEncode(order.toJson()),
//       );
//
//       // Handle response
//       if (response.statusCode == 200) {
//         // Order placed successfully
//         print('Order placed successfully: ${response.body}');
//         Get.snackbar('Success', 'Order placed successfully!');
//         // Optionally, navigate to a success page
//       } else if (response.statusCode == 500) {
//         // Handle validation errors
//         print('Validation errors: ${response.body}');
//         Get.snackbar('Error', 'Validation errors occurred.');
//       } else {
//         // Handle other errors
//         print('Failed to place order: ${response.statusCode}');
//         Get.snackbar('Error', 'Failed to place order. Please try again.');
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception: $e');
//       Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
//     }
//   } catch (e) {
//     print('Error processing cart items: $e');
//     Get.snackbar('Error', 'There was a problem processing your cart items. Please check and try again.');
//   }
// }
