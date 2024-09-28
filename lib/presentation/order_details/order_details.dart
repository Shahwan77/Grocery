import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/widgets/button/button.dart';

import '../../data/apiClient/api.dart';
import '../Cart/cart_controller.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Wrap Column in SingleChildScrollView
        child: Column(
          children: [
            Container(
              height: 156.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        SizedBox(width: 90.w),
                        Text(
                          'Order Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Ashique Mohammed',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      '+9699023784',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '24 United Arab Emirates 13 4 Mai Tower-\nOffice No 701 -\nالنهدة - دبي - United Arab Emirates',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                            if (cartController.isLoggedIn() &&
                                cartController.getCartItems().isNotEmpty) ...[
                              Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: IntrinsicWidth(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Text(
                                        "\$${cartController.total_amount.value}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ]
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Issued on',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '01-08-2024',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kilometer',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1.17 km',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Ordered items',
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cartController.getCartItems().length,
                    itemBuilder: (context, index) {
                      final item = cartController.getCartItems()[index];
                      return Column(
                        children: [
                          ListTile(
                            // contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
                            leading: Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.network(
                                  '${Api.ImageUrl}/products/${item['image']}',
                                  width: 80.w,
                                  height: 80.h,
                                  fit: BoxFit
                                      .cover, // Ensure image fits within the container
                                ),
                              ),
                            ),
                            title: Text(
                              item['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  item['price'],
                                  style: TextStyle(color: Colors.green),
                                ),
                                SizedBox(
                                    width: 5
                                        .w), // Add some spacing between price and quantity
                                Text(
                                  '*${item['quantity']}',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            trailing: Text(
                              calculateTotalPrice(
                                  item['price'], item['quantity']),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            tileColor: Colors
                                .grey.shade200, // Background color for the tile
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      );
                    },
                  ),
                  Divider(
                    thickness: 1.6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            if (cartController.isLoggedIn() &&
                                cartController.getCartItems().isNotEmpty) ...[
                              Obx(() {
                                return Text(
                                  "\$${cartController.total_amount.value}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                            ],
                          ],
                        ),
                        Divider(
                          thickness: 1.4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "0.00",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Charges',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "0.00",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                            if (cartController.isLoggedIn() &&
                                cartController.getCartItems().isNotEmpty) ...[
                              Obx(() {
                                return Text(
                                  "\$${cartController.total_amount.value}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.green,
                                  ),
                                );
                              }),
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button(
                        size: Size(80.w, 44.h),
                        color: Colors.red,
                        text: Text('Prev',style: TextStyle(color: Colors.white),),
                        ontap: () {
                      },),
                      SizedBox(width: 18.w,),
                      Button(
                        size: Size(80.w, 44.h),
                        color: Colors.red,
                        text: Text('Next',style: TextStyle(color: Colors.white),),
                        ontap: () {
                        },),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String calculateTotalPrice(dynamic price, dynamic quantity) {
  try {
    final double priceValue =
        price is int ? price.toDouble() : double.parse(price.toString());
    final int quantityValue =
        quantity is int ? quantity : int.parse(quantity.toString());

    final double total = priceValue * quantityValue;

    return total.toStringAsFixed(2);
  } catch (e) {
    return '0.00';
  }
}
