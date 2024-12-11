import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:grocery/presentation/account/change_email/change_email.dart';
import 'package:grocery/presentation/account/change_number/change_number_otp.dart';
import 'package:grocery/presentation/account/edit_profile/edit_profile.dart';
import 'package:grocery/presentation/account/user_data.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/register_model.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
import '../order_details/my_orders_view.dart';
import '../order_details/my_ordrs.dart';
import '../sign_up_screen/controller/signup_controller.dart';
import 'address/address.dart';
import 'change_password/change_password.dart';
import 'language.dart';
import 'notification/notification.dart';

class Account extends StatelessWidget {
  Account({super.key});
  final CartController cartController = Get.put(CartController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());

  // List of icons and corresponding translation keys
  final List<IconData> accounticon = [
    Icons.notifications_outlined,
    Icons.shopping_cart,
    Icons.language_outlined,
    Icons.location_on_outlined,
    Icons.email_outlined,
    Icons.edit_outlined,
    Icons.more_horiz,
    Icons.phone_android_outlined,
    Icons.logout,
  ];

  // Translation keys corresponding to each account item
  final List<String> accountTextKeys = [
    'notification', // "Notification"
    'my_orders', // "My Orders"
    'language',
    'add_address', // "Add Address"
    'change_email', // "Change Email"
    'edit_profile', // "Edit Profile"
   'change_password', // "Change Password"
    'change_mobile', // "Change Mobile"
    'logout', // "Logout"
  ];

  Future<void> logout() async {
    final box = GetStorage();
    final token = box.read('access_token');
    final response = await http.post(
      Uri.parse(Api.Logout),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successfully logged out
      print(response.body);
      GetStorage().remove('access_token'); // Clear the token
      Get.snackbar('Logout', 'Successfully logged out',
          snackPosition: SnackPosition.BOTTOM);
      cartController.clearLocalCart();
      Get.offAll(
          CustomBottomNavBar()); // Navigate to bottom nav (change as needed)
    } else {
      // Handle error
      final Map<String, dynamic> responseData = json.decode(response.body);
      //Get.snackbar('Error', responseData['message'], snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final SignupController signupController = Get.put(SignupController());
    final token = box.read('access_token');

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
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
            padding: EdgeInsets.symmetric(),
            child: token != null
                ? FutureBuilder<User?>(
                    future: UserData().fetchUser(), // Fetch user data
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(
                        ));
                      }
                      // else if (snapshot.hasError) {
                      //   return Center(child: Text('Error: ${snapshot.error}'));
                      // }
                      else if (snapshot.hasData) {
                        final user = snapshot.data;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                height: 110.h,
                                width: 320.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26.r),
                                  color: Color(0xFFEB1C23),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14.w, vertical: 12.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 84.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.r),
                                              color: Colors.white,
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child:ClipOval(
                                                child: user?.image == null || user!.image!.isEmpty
                                                    ? Icon(
                                                  Icons.person, // Default icon
                                                  size: 60.h,
                                                )
                                                    : Image.network(
                                                  '${Api.ImageUrl}/users/${user.image}',
                                                  height: 60.h,
                                                  width: 70.w,
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Icon(
                                                      Icons.person, // Fallback icon
                                                      size: 60.h,
                                                    );
                                                  },
                                                ),
                                              )

                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user?.name ??
                                                    'NAME', // Displaying user's name
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(
                                                user?.email ??
                                                    'Email', // Displaying user's name
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                child: ListView.builder(
                                  itemCount: accounticon.length,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final accountText = accountTextKeys[index]
                                        .tr; // Directly using the translation key
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: ListTile(
                                          leading: Container(
                                            width: 34.w,
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                            ),
                                            child: Icon(accounticon[index]),
                                          ),
                                          title: Text(
                                              accountText), // Translated text
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded),
                                          onTap: () {
                                            if (accountText == 'logout'.tr) {
                                              Get.dialog(
                                                Directionality(
                                                  textDirection: TextDirection.ltr,
                                                  child: AlertDialog(
                                                    title: Text('logout'
                                                        .tr), // Localized title
                                                    content: Text(
                                                        'Are you sure you want to logout?'),
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
                                                ),
                                              );
                                            } else if (accountText ==
                                                'notification'.tr) {
                                              Get.to(
                                                  NotificationPage()); // Navigate to My Orders
                                            } else if (accountText ==
                                                'my_orders'.tr) {
                                              Get.to(
                                                  OrderPage()); // Navigate to My Orders
                                            } else if (accountText ==
                                                'language'.tr) {
                                              Get.to(LanguagePage());
                                            } else if (accountText ==
                                                'add_address'.tr) {
                                              Get.to(AddressPage());
                                            }
                                            else if (accountText ==
                                                'change_email'.tr) {
                                              Get.to(ChangeEmailPage());
                                            }
                                            else if (accountText ==
                                                'edit_profile'.tr) {
                                              Get.to(EditProfile());
                                            }
                                            else if (accountText ==
                                                'change_password'.tr) {
                                              Get.to(ChangePassword());
                                            }
                                            else if (accountText ==
                                                'change_mobile'.tr) {
                                              Get.to(ChangeNumberOtp());
                                            }
                                            else {
                                              print('Tapped on $accountText');
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text('No user data found.'));
                      }
                    },
                  )
                : LoginPage()),
      ),
    );
  }
}
