import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Cart/cart_page.dart';
import 'package:grocery/presentation/Delivery%20Time%20Slots/delivery_time_slots.dart';
import 'package:grocery/presentation/home_screen/page/home_page.dart';
import 'package:grocery/tst12.dart';
import 'package:grocery/widgets/button/button.dart';

import '../../data/apiClient/api.dart';
import '../../data/models/register_model.dart';
import '../../tstts.dart';
import '../Cart/cart_controller.dart';
import '../Language Selection/language_controller.dart';
import '../account/user_data.dart';
import '../sign_up_screen/controller/signup_controller.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});
  final CartController cartController = Get.put(CartController());
  final SignupController signupController = Get.put(SignupController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());

  GetStorage Box = GetStorage();
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
          backgroundColor: Color(0xFFEB1C23),
          leading: IconButton(
            icon: Container(
                height: 22.h,
                width: 26.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Center(
                    child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFFEB1C23),
                  size: 20.sp,
                ))),
            onPressed: () {
              Get.back();
            },
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Text(
              languagecontroller.orderText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 96.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFEB1C23),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: token != null
                      ? FutureBuilder<User?>(
                          future: UserData().fetchUser(), // Fetch user data
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              final user = snapshot.data;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 6.h),
                                  Text(
                                    user?.name??'Name',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  Text(
                                    user?.mobileNo??'Ph no:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                           languagecontroller.totalamountText,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          if (cartController.isLoggedIn() &&
                                              cartController
                                                  .getCartItems()
                                                  .isNotEmpty) ...[
                                            Obx(() {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20.r),
                                                ),
                                                child: IntrinsicWidth(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 8.w),
                                                    child: Text(
                                                      "\$${cartController.total_amount.value}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18.sp,
                                                        color: Colors.black,
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
                              );
                            } else {
                              return Center(child: Text('No user data found.'));
                            }
                          },
                        )
                      : Center(
                          child: Text(
                           languagecontroller.pleaseloginText,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
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
                              languagecontroller.issuedText,
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
                              languagecontroller.kmText,
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
                     languagecontroller.orderitemsText,
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
                                    size: 50.sp,
                                    color: Colors.grey,
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
                                  if (Box.read('selectedButton') == 'grocery') ...[
                                    Text(
                                      item['price'],
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    SizedBox(
                                      width: 5.w, // Add some spacing between price and quantity
                                    ),
                                    Text(
                                      '*${item['quantity']}',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ]
                                  // else  if (Box.read('selectedButton') == 'laundry') ...[
                                  //   Text('${item['services'].join(', ')}', style: TextStyle(fontSize: 16)),
                                  // ]

                                    else if (Box.read('selectedButton') == 'laundry') ...[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: (item['services'] as List<dynamic>? ?? []).map<Widget>((service) {
                                          final serviceName = (service is Map && service['name'] != null)
                                              ? service['name']
                                              : 'Unknown Service';
                                          print('Services: ${item['services']}');
                                          return Text(
                                            serviceName,
                                            style: TextStyle(fontSize: 16),
                                          );
                                        }).toList(),
                                      ),
                                    ],
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
                                  .grey.shade200,
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
                               languagecontroller.totalamountText,
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
                          color: Color(0xFFEB1C23),
                          text: Text(
                            languagecontroller.prevText,
                            style: TextStyle(color: Colors.white),
                          ),
                          ontap: () {
                            Get.back();
                          },
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Button(
                          size: Size(80.w, 44.h),
                          color: Color(0xFFEB1C23),
                          text:
                              Text(languagecontroller.nextText, style: TextStyle(color: Colors.white)),
                          ontap: () {
                            // List<dynamic> cartItems = cartController.getCartItems();
                            // if (cartItems.isNotEmpty) {
                            //   print('Order Details:');
                            //   for (var item in cartItems) {
                            //     print(item);
                            //     print(cartController.total_amount);
                            //     print(cartController.total_quantity);
                            //   }
                            // } else {
                            //   print('No items in the cart.');
                            // }
      
                            // Navigate to DeliveryTimeSlots
                            List<dynamic> cartItems =
                                cartController.getCartItems();
                            Get.to(DeliveryTimeSlots(
                              cartItems: cartItems,
                            ));
                          },
                        ),
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
