import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'package:lottie/lottie.dart';
import '../../data/apiClient/api.dart';
import '../../widgets/button/button.dart';
import '../bottomnav/controller/bottomnav_controller.dart';
import 'cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Cart',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset('assets/Animation - 1724233631425.json'),
              ),
              SizedBox(height: 20.h),
              Text(
                'Your Cart is empty!',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),
              Button(
                size: Size(164, 54),
                color: Colors.green.shade800,
                text: Text(
                  'Start Shopping',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                ontap: () {
                  // final BottomNavController bottomNavController = Get.find<BottomNavController>();
                  // bottomNavController.updateIndex(0);
                  // Get.offAll(CustomBottomNavBar());
                },
              )
            ],
          );

        }
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // To allow scrolling and pull to refresh
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: cartController.getCartItems().length,
                itemBuilder: (context, index) {
                  final item = cartController.getCartItems()[index];
                  return Container(
                    height: 114.h,
                    margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.network(
                                  '${Api.ImageUrl}/products/${item['image']}',
                                  width: 80.w,
                                  height: 80.h,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 70.h,
                              right: 34.w,
                              left: 35,
                              child: Container(
                                height: 30.h,
                                width: 34.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(14.r),
                                    bottomLeft: Radius.circular(14.r),
                                  ),
                                ),
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/dlt.png',
                                    width: 20.w,
                                    height: 20.h,
                                    color: Colors.red.shade600,
                                  ),
                                  onPressed: () {
                                    cartController.removeFromCart(
                                      item['name'],
                                      item['price'],
                                      item['image'],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['price'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              color: item['quantity'] > 1
                                                  ? Colors.red.shade600
                                                  : Colors.grey,
                                            ),
                                            onPressed: () {
                                              if (item['quantity'] > 1) {
                                                cartController.updateQuantity(
                                                    item['name'], -1);
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          '${item['quantity']}',
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Container(
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: item['quantity'] > 1
                                                  ? Colors.green.shade800
                                                  : Colors.grey,
                                            ),
                                            onPressed: () {
                                              cartController.updateQuantity(
                                                  item['name'], 1);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Button(
                color: Colors.green.shade800,
                size: Size(340.w, 45.h),
                text: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
                ontap: () {
                  Get.to(LoginPage());
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      }),
    );
  }
}