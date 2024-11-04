// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../widgets/button/button.dart';
//
// class OrderedProducts extends StatelessWidget {
//   const OrderedProducts({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> orderedItems = [
//       {
//         "name": "Saffola Masala Oats I Healthy Snack I\nClassic Masala 1Kg",
//         "quantity": 1,
//         "price": 18.80
//       },
//       {
//         "name": "Saffola Masala Oats I Healthy Snack I\nClassic Masala 1Kg",
//         "quantity": 4,
//         "price": 18.80
//       },
//       {
//         "name": "Saffola Masala Oats I Healthy Snack I\nClassic Masala 1Kg",
//         "quantity": 10,
//         "price": 18.80
//       },
//       {
//         "name": "Saffola Masala Oats I Healthy Snack I\nClassic Masala 1Kg",
//         "quantity": 4,
//         "price": 18.80
//       },
//       {
//         "name": "Saffola Masala Oats I Healthy Snack I\nClassic Masala 1Kg",
//         "quantity": 4,
//         "price": 18.80
//       },
//     ];
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Container(
//             height: 22.h,
//             width: 26.w,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30.r),
//             ),
//             child: Center(
//               child: Icon(
//                 Icons.arrow_back_ios_rounded,
//                 color: Color(0xFFEB1C23),
//                 size: 20.sp,
//               ),
//             ),
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         backgroundColor: Color(0xFFEB1C23),
//         title: Text(
//           '#7584639248',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Icon(Icons.person_pin, color: Colors.white),
//                 SizedBox(width: 18.w),
//                 GestureDetector(
//                     onTap: () {},
//                     child: Icon(Icons.print, color: Colors.white)),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: orderedItems.length,
//               itemBuilder: (context, index) {
//                 final item = orderedItems[index];
//                 return GestureDetector(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           backgroundColor: Colors.white,
//                           contentPadding: EdgeInsets.all(10.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.r),
//                           ),
//                           content: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // Close button
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.back();
//                                     },
//                                     child: Icon(Icons.cancel),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10.h),
//                               Image.asset(
//                                 'assets/aaa.png',
//                                 width: 80.w,
//                                 height: 80.h,
//                               ),
//                               SizedBox(height: 20.h),
//                               Padding(
//                                 padding:  EdgeInsets.symmetric(horizontal: 10.w),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Item: ${item['name']}",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 13.sp,
//                                       ),
//                                       maxLines: 2,
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     Text(
//                                       'Barcode: #7584639248',
//                                       style: TextStyle(
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     Text(
//                                       'Quantity: ${item['quantity']}',
//                                       style: TextStyle(
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     Text(
//                                       'Amount: AED ${item['price'].toStringAsFixed(2)}',
//                                       style: TextStyle(
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           actions: [
//                             Center(
//                               child: Button(
//                                 size: Size(280.w, 34.h),
//                                 color: Color(0xFFEB1C23),
//                                 text: Text(
//                                   'REPLACE THE PRODUCT',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 ontap: () {},
//                               ),
//                             ),
//                             SizedBox(height: 10.h),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
//                     child: Card(
//                       elevation: 4,
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 14.w, vertical: 16.h),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image.asset(
//                               'assets/aaa.png',
//                               width: 70.w,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item['name'],
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 10.sp,
//                                   ),
//                                   maxLines: 2,
//                                 ),
//                                 SizedBox(height: 4.h),
//                                 Text(
//                                   '#7584639248',
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 14.sp,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4.h),
//                                 Text(
//                                   'AED ${item['price'].toStringAsFixed(2)}',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14.sp,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                   'Qty: ${item['quantity']}',
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14.sp,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 10.h),
//             child: Row(
//               children: [
//                 Container(
//                   width: 220.w,
//                   height: 50.h,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFEB1C23),
//                     borderRadius: BorderRadius.circular(18.r),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     'TOTAL AMOUNT: 112.8 AED',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 SizedBox(width: 5.w),
//                 Button(
//                   text: Text('FINISH', style: TextStyle(color: Colors.white)),
//                   color: Colors.green,
//                   size: Size(100.w, 50.h),
//                   ontap: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
