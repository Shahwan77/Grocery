// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:grocery/Admin/staff_controller.dart';
// import 'package:grocery/Admin/to_do_controller.dart';
// import '../widgets/button/button.dart';
//
// class ToDo extends StatelessWidget {
//   final StaffController staffController = Get.put(StaffController());
//   final OrderController orderController = Get.put(OrderController());
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<void>(
//       future: orderController.fetchAdminOrderlist(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (orderController.orders.isEmpty) {
//           return Center(child: Text('No orders available'));
//         }
//
//         final orders = orderController.orders;
//
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20),
//               Text(
//                 'Unassigned',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: orders.length,
//                   itemBuilder: (context, index) {
//                     var order = orders[index];
//                     return Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(16),
//                         tileColor: Color(0xFFEB1C23),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         title: Row(
//                           children: [
//                             Icon(Icons.article, color: Colors.white),
//                             SizedBox(width: 8),
//                             Text(
//                               order.orderId ?? 'No ID',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                         subtitle: Row(
//                           children: [
//                             Icon(Icons.person, color: Colors.white, size: 20),
//                             SizedBox(width: 8),
//                             Text(
//                               '${order.user.name ?? 'No User'}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         trailing: GestureDetector(
//                           onTap: () {
//                             showModalBottomSheet(
//                               backgroundColor: Colors.grey.shade100,
//                               context: context,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(20.r),
//                                 ),
//                               ),
//                               builder: (BuildContext context) {
//                                 return Directionality(
//                                   textDirection: TextDirection.ltr,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(16.w),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.article,
//                                                   color: Colors.grey,
//                                                 ),
//                                                 Text(
//                                                   order.orderId,
//                                                   style: TextStyle(
//                                                     fontSize: 16.sp,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Container(
//                                               width: 70.w,
//                                               height: 26.h,
//                                               decoration: BoxDecoration(
//                                                 color: Color(0xFFFFC107),
//                                                 borderRadius:
//                                                 BorderRadius.circular(8.r),
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(Icons.logout_outlined,
//                                                       size: 16,
//                                                       color: Colors.white),
//                                                   SizedBox(width: 4.w),
//                                                   Text(
//                                                     'Left',
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: 10.h),
//                                         Row(
//                                           children: [
//                                             Icon(Icons.person, color: Colors.grey),
//                                             SizedBox(width: 8.w),
//                                             Text(
//                                               '${order.userId}',
//                                               style: TextStyle(fontSize: 16.sp),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: 20.h),
//                                         Text(
//                                           'Select Staff:',
//                                           style: TextStyle(
//                                               fontSize: 16.sp,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         SizedBox(height: 10.h),
//                                         Obx(() {
//                                           return Wrap(
//                                             spacing: 10.w,
//                                             runSpacing: 10.h,
//                                             children: staffController.staffList.map((staff) {
//                                               return ChoiceChip(
//                                                 label: Text(staff.name),
//                                                 selected: staffController.selectedStaff.value == staff.id.toString(),
//                                                 onSelected: (selected) {
//                                                   // Ensure the selected staff ID is updated as a string
//                                                   staffController.selectedStaff.value = selected ? staff.id.toString() : '';
//                                                 },
//                                                 selectedColor: Colors.green, // Set color when selected
//                                                 backgroundColor: Colors.grey.shade300, // Set color when not selected
//                                                 labelStyle: TextStyle(color: Colors.black), // Label text color
//                                               );
//                                             }).toList(),
//                                           );
//                                         }),
//                                         SizedBox(height: 20.h),
//                                         Center(
//                                           child: Button(
//                                             size: Size(320.w, 38.h),
//                                             color: Colors.green,
//                                             text: Text(
//                                               'CONFIRM',
//                                               style: TextStyle(color: Colors.white),
//                                             ),
//                                             ontap: () {
//                                               Navigator.pop(context);
//
//                                               // Print the selected order ID and staff ID
//                                               print('Selected Order ID: ${order.orderId}');
//                                               print('Selected Staff ID: ${staffController.selectedStaff.value}');
//
//                                               // Perform the POST request with the selected IDs here
//                                               staffController.assignStaffToOrder(order.orderId, staffController.selectedStaff.value);
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Container(
//                             width: 70.w,
//                             height: 26.h,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFFFC107),
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.logout_outlined,
//                                     size: 16, color: Colors.white),
//                                 SizedBox(width: 4.w),
//                                 Text(
//                                   'Left',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
