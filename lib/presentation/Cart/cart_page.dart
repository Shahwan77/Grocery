import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/order_details/order_details.dart';
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'package:lottie/lottie.dart';
import '../../data/apiClient/api.dart';
import '../../tstts.dart';
import '../../widgets/button/button.dart';
import '../bottomnav/controller/bottomnav_controller.dart';
import 'cart_controller.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final token = GetStorage().read('access_token');

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
        backgroundColor: Color(0xFFEB1C23),
      ),
      body: FutureBuilder<void>(
        future:
        cartController.fetchCartItems(token ?? ''), // Fetch the cart items
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(() {
              // Check if fetched cart items are empty after fetching
              if (cartController.fetchedcartItems.isEmpty &&
                  cartController.cartItems.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child:
                      Lottie.asset('assets/Animation - 1724233631425.json'),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Your Cart is empty!',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20.h),
                    Button(
                      size: Size(164, 54),
                      color: Color(0xFFEB1C23),
                      text: Text(
                        'Start Shopping',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      ontap: () {
                        // Navigate to the shopping page or bottom nav
                      },
                    )
                  ],
                );
              }

              // Check if there are items in the cart
              if (cartController.getCartItems().isNotEmpty) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: cartController.getCartItems().length,
                        itemBuilder: (context, index) {
                          final item = cartController.getCartItems()[index];
                          final int productId = item['product_id'];
                          return Container(
                            height: 114.h,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 10.w),
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
                                        borderRadius:
                                        BorderRadius.circular(20.r),
                                        color: Colors.white,
                                      ),
                                      child:Center(
                                        child: item['image'] != null && item['image'].isNotEmpty
                                            ? Image.network(
                                          '${Api.ImageUrl}/products/${item['image']}',
                                          width: 80.w,
                                          height: 80.h,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Icon(
                                            Icons.hide_image_outlined,
                                            size: 90.sp,
                                            color: Colors.grey,
                                          ),
                                        )
                                            : Icon(
                                          Icons.hide_image_outlined,
                                          size: 60.sp,
                                          color: Colors.grey,
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
                                            color: Color(0xFFEB1C23),
                                          ),
                                          onPressed: () {
                                            final productId = item['product_id'];

                                            if (token != null) {
                                              cartController.removeItemFromCart(productId);
                                            } else {
                                              cartController.removeFromCart(
                                                item['name'],
                                                item['price'],
                                                item['image'],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                // Decrement Button
                                                Container(
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: (item['quantity'] ?? 0) > 1 // Check if quantity is greater than 1
                                                          ? Colors.red.shade600
                                                          : Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      // Allow decrement only if quantity is greater than 1
                                                      if ((item['quantity'] ?? 0) > 1) {
                                                        cartController.updateQuantity(productId, -1);
                                                      }
                                                    },
                                                  ),
                                                ),

                                                SizedBox(width: 5.w),

                                                // Display Quantity
                                                Text(
                                                  '${item['quantity'] ?? 0}', // Handle null values safely
                                                  style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),

                                                SizedBox(width: 5.w),

                                                // Increment Button
                                                Container(
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Colors.green.shade800,
                                                    ),
                                                    onPressed: () {
                                                      // Increment the quantity by 1
                                                      cartController.updateQuantity(productId, 1);
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
                      // Display total amount only if logged in and items exist in the cart
                      if (cartController.isLoggedIn() &&
                          cartController.getCartItems().isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp)),
                            SizedBox(width: 10),
                            Obx(() {
                              return Text(
                                "\$${cartController.total_amount.value}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: Colors.green.shade800,
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 6.h,),
                      ],
                      // Show the Continue button if there are items in the cart
                      if (cartController.getCartItems().isNotEmpty) ...[
                        Button(
                          color: Color(0xFFEB1C23),
                          size: Size(340.w, 45.h),
                          text: Text(
                            "Continue",
                            style: TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                          ontap: () async {
                            if (!cartController.isLoggedIn()) {
                              await Get.to(() => LoginPage());
                            } else {
                              await Get.to(OrderDetails());
                            }
                          },
                        ),
                      ],
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child:
                      Lottie.asset('assets/Animation - 1724233631425.json'),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Your Cart is empty!',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20.h),
                    Button(
                      size: Size(164, 54),
                      color: Color(0xFFEB1C23),
                      text: Text(
                        'Start Shopping',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      ontap: () {
                        // Navigate to the shopping page or bottom nav
                      },
                    )
                  ],
                );// Return an empty message if there's no data
              }
            });
          }
        },
      ),
    );
  }
}
