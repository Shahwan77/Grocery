import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/home_screen/page/home_page.dart';
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'package:grocery/presentation/sign_up_screen/controller/signup_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/models/register_model.dart';
import '../tst12.dart';

class Account extends StatelessWidget {
  Account({super.key});

  final List<String> account = [
    'Notification',
    'Add Address',
    'Change Email Address',
    'Edit Profile',
    'Change Password',
    'Change Mobile Number',
    'Logout',
  ];

  final List<IconData> accounticon = [
    Icons.notifications_outlined,
    Icons.location_on_outlined,
    Icons.email_outlined,
    Icons.edit_outlined,
    Icons.more_horiz,
    Icons.phone_android_outlined,
    Icons.logout,
  ];

  Future<void> logout() async {
    final box = GetStorage();
    final token = box.read('access_token');
    final response = await http.post(
      Uri.parse('https://grocery-dev.greendomains.in/api/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successfully logged out
      print(response.body);
      GetStorage().remove('access_token'); // Clear the token
      Get.snackbar('Logout', 'Successfully logged out', snackPosition: SnackPosition.BOTTOM);
      Get.offAll(CustomBottomNavBar()); // Navigate to login screen (change to your login route)
    } else {
      // Handle error
      final Map<String, dynamic> responseData = json.decode(response.body);
      Get.snackbar('Error', responseData['message'], snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final SignupController signupController = Get.put(SignupController());
    final token = box.read('access_token');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 8.h,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFFEB1C23),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Color(0xFFEB1C23),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: token != null
            ?  Column(
                children: [
                  Container(
                    height: 110.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26.r),
                      color: Color(0xFFEB1C23),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 84.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.r),
                                  color: Colors.white,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.person,
                                    size: 50.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                Details().name, // Displaying the user's name or placeholder
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              //Text(Details().mobileNo)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListView.builder(
                    itemCount: account.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 34.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Icon(accounticon[index]),
                            ),
                            title: Text(account[index]),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {
                              if (account[index] == 'Logout') {
                                Get.dialog(
                                  AlertDialog(
                                    title: Text('Logout Confirmation'),
                                    content: Text('Are you sure you want to logout?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back(); // Close the dialog
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back(); // Close the dialog
                                          logout(); // Call the logout function
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                print('Tapped on ${account[index]}');
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            : Center(
          child: Text(
            'Please login to access your account',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
