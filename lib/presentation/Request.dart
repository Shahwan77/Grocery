// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class Request extends StatelessWidget {
//    Request({super.key});
//   int _selectedIndex = 0;
//   bool _showTotalSales = true;
//   bool _showPendingCoupon = false;
//   bool _showRequest = false;
//
//   List<int> firstTexts = [10, 9, 6, 7, 9, 6];
//   List<int> secondTexts = [100, 500, 1000, 2000, 5000, 10000];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   void _showContainer(String container) {
//     setState(() {
//       _showTotalSales = container == 'totalSales';
//       _showPendingCoupon = container == 'pendingCoupon';
//       _showRequest = container == 'request';
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//         height: 375.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_back,
//                         size: 30.sp,
//                       ),
//                       onPressed: () {
//                         _showContainer('totalSales');
//                       },
//                     ),
//
//                     Padding(
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 60.w),
//                       child: Text(
//                         'Request Coupons',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.sp,
//                           color: Color(0xFF800000),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 30.w),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: 6,
//                       itemBuilder: (context, index) {
//                         TextStyle textStyle = TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                         );
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment
//                               .spaceBetween, // Ensures even spacing between items
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                   vertical: 2.h,
//                                 ),
//                                 width: 250
//                                     .w, // Adjust the width according to your needs
//                                 height: 38.h,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade100,
//                                   borderRadius:
//                                   BorderRadius.circular(10.r),
//                                   border: Border.all(
//                                       color: Colors.grey.shade200),
//                                 ),
//                                 child: Center(
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment
//                                         .spaceEvenly,
//                                     children: [
//                                       Text(
//                                         '${secondTexts[index]}/-',
//                                         style: textStyle,
//                                       ),
//                                       Padding(
//                                         padding:
//                                         const EdgeInsets.all(
//                                             8.0),
//                                         child: Container(
//                                           width: 80
//                                               .w, // You can adjust this width as necessary
//                                           height: 50.h,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                             BorderRadius
//                                                 .circular(8.r),
//                                             border: Border.all(
//                                                 color: Colors.grey),
//                                           ),
//                                           child: TextField(
//                                             decoration:
//                                             InputDecoration(
//                                               hintText: 'QTY',
//                                               hintStyle: TextStyle(
//                                                   color:
//                                                   Colors.grey,
//                                                   fontSize: 15.sp),
//                                               border:
//                                               InputBorder.none,
//                                               contentPadding:
//                                               EdgeInsets
//                                                   .symmetric(
//                                                   vertical:
//                                                   5.5.h,
//                                                   horizontal:
//                                                   5.w),
//                                             ),
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 15.sp),
//                                             textAlign:
//                                             TextAlign.center,
//                                             keyboardType:
//                                             TextInputType
//                                                 .number,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 6.w,
//                             ),
//                             Container(
//                                 width: 40.w,
//                                 height: 24.h,
//                                 decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color(0xFF5B247A),
//                                         Color(0xFF2AA7C8),
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     borderRadius:
//                                     BorderRadius.circular(
//                                         30.r)),
//                                 child: Icon(
//                                   Icons.arrow_forward,
//                                   size: 24.sp,
//                                   color: Colors.white,
//                                 )), // Adjust the icon size if needed
//                           ],
//                         );
//                       },
//                     )),
//               ],
//             ),
//           ),
//         ));
//   }
// }
