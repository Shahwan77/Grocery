// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:grocery/data/apiClient/api.dart';
//
// import 'data/models/register_model.dart';
// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
//
// class UserData {
//   final box = GetStorage();
//
//   Future<User?> fetchUser() async {
//     final String? token = box.read('access_token');
//     final response = await http.get(
//       Uri.parse(Api.User),
//       headers: {
//         "Authorization": "Bearer $token",
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final user = User.fromJson(data['user']); // Accessing the 'user' key
//       box.write('id', user.id);
//       box.write('name', user.name);
//       return user;
//     } else {
//       print("Failed to fetch user data: ${response.statusCode}");
//       return null;
//     }
//   }
// }
//
// class MyAppstatata extends StatelessWidget {
//   final UserData userData = UserData();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('User Info')),
//       body: FutureBuilder<User?>(
//         future: userData.fetchUser(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final user = snapshot.data!;
//             return Center(
//               child: Text(
//                 'Name: ${user.name}', // Displaying the user's name
//                 style: TextStyle(fontSize: 20),
//               ),
//             );
//           } else {
//             return Center(child: Text('No user data found.'));
//           }
//         },
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grocery/presentation/home_screen/controller/home_controller.dart';
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
//     HomeController homeController = Get.put(HomeController());
//
//     return AppBar(
//       systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: Color(0xFFEB1C23),
//         statusBarIconBrightness: Brightness.light,
//       ),
//       surfaceTintColor: Colors.white,
//       backgroundColor: Color(0xFFEB1C23),
//       elevation: 0,
//       toolbarHeight: toolbarHeight,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Grocery Container
//               Obx(() => Container(
//                 height: 64.h,
//                 width: 74.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.r),
//                   color: homeController.selectedIndex.value == 0
//                       ? Colors.redAccent
//                       : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5.0,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     homeController.fetchCategories();
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset('assets/logo.png', width: 40.w),
//                       Text(
//                         'Grocery',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                           color: homeController.selectedIndex.value == 0
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//
//               // Laundry Container
//               Obx(() => Container(
//                 height: 64.h,
//                 width: 74.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.r),
//                   color: homeController.selectedIndex.value == 1
//                       ? Colors.redAccent
//                       : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5.0,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     homeController.fetchLaundry();
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset('assets/laundry2.png', width: 40.w),
//                       Text(
//                         'Laundry',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                           color: homeController.selectedIndex.value == 1
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//
//               // Offers Container
//               Obx(() => Container(
//                 height: 64.h,
//                 width: 74.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.r),
//                   color: homeController.selectedIndex.value == 2
//                       ? Colors.redAccent
//                       : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5.0,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     // Handle Offers tap if needed
//                     homeController.selectedIndex.value = 2;
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset('assets/offers2.png', width: 40.w),
//                       Text(
//                         'Offers',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                           color: homeController.selectedIndex.value == 2
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//
//               // AJ Container
//               Obx(() => Container(
//                 height: 64.h,
//                 width: 74.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.r),
//                   color: homeController.selectedIndex.value == 3
//                       ? Colors.redAccent
//                       : Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5.0,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     // Handle AJ tap if needed
//                     homeController.selectedIndex.value = 3;
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset('assets/aj3.png', width: 70.w, height: 50),
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 6),
//                         child: Text(
//                           'AJ',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                             color: homeController.selectedIndex.value == 3
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(toolbarHeight);
// }
//
//
//
//
