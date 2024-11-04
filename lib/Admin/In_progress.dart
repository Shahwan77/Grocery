// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../Admin/staff_controller.dart';
// import '../data/models/in_progress_model.dart';
// import '../presentation/Language Selection/language_controller.dart';
// import '../widgets/button/button.dart';
// import 'in_progress_controller.dart';
// import 'ordered_products.dart';
//
// class InProgress extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final InProgressController inProgressController = Get.put(InProgressController());
//     final StaffController staffController = Get.put(StaffController());
//     final WelcomeController languageController = Get.put(WelcomeController());
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 10.h),
//           FutureBuilder<void>(
//             future: inProgressController.fetchInProgressOrders(),
//             builder: (context, snapshot) {
//               // Show loading indicator while the data is being fetched
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//
//               // Handle error state
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error loading orders: ${snapshot.error}'));
//               }
//
//               // Display a message if no orders are available
//               if (inProgressController.orders.isEmpty) {
//                 return Center(child: Text('No orders found'));
//               }
//
//               // Display orders once data has loaded
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: inProgressController.orders.length,
//                   itemBuilder: (context, index) {
//                     var item = inProgressController.orders[index];
//                     return Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.h),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(16.w),
//                         tileColor: Color(0xFFEB1C23),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         title: Row(
//                           children: [
//                             Icon(Icons.article, color: Colors.white),
//                             SizedBox(width: 8.w),
//                             Text(
//                               item.orderId,
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                         subtitle: Row(
//                           children: [
//                             Icon(Icons.person, color: Colors.white, size: 20),
//                             SizedBox(width: 8.w),
//                             Text(
//                               item.user.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Icons.person_pin_rounded, size: 16, color: Colors.white),
//                             SizedBox(width: 4.w),
//                             Text(
//                               item.staff.name,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(width: 4.w),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(OrderedProducts());
//                               },
//                               child: Container(
//                                 height: 16.h,
//                                 width: 19.w,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(30.r),
//                                 ),
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.arrow_forward_ios_rounded,
//                                     color: Color(0xFFEB1C23),
//                                     size: 16.sp,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
