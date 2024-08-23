import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/button/button.dart';
import 'cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Cart',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
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
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),
              Button(
                size: Size(164, 54),
                color: Colors.green.shade800,
                text: Text(
                  'Start Shopping',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                ontap: () {},
              )
            ],
          );
        }
        return ListView.builder(
          itemCount: cartController.getCartItems().length,
          itemBuilder: (context, index) {
            final item = cartController.getCartItems()[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading:  Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 60,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            item['image'],
                            width: 80, // Set width to match the container
                            height: 60, // Set height to match the container
                            //fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 34.h,
                          right: 20.w,
                          child: Container(
                            height: 32,
                            width: 34,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 20,
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
                    title: Text(
                      item['name'],
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                            Text(
                              item['price'],
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                            //Obx((){

                            Padding(
                              padding: const EdgeInsets.symmetric(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: item['quantity'] > 1
                                            ? Colors.red.shade800
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
                                  SizedBox(width: 5.w,),
                                  Text(
                                    '${item['quantity']}',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(width: 5.w,),
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
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
                            // })
                      ],
                    ),
                    // trailing: IconButton(
                    //   icon: Icon(
                    //     Icons.delete_outline_outlined,
                    //     color: Colors.green.shade800,
                    //   ),
                    //   onPressed: () {
                    //     cartController.removeFromCart(
                    //       item['name'],
                    //       item['price'],
                    //       item['image'],
                    //     );
                    //   },
                    // ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
