import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Products/products_controller.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/order_details/order_details.dart';
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'package:lottie/lottie.dart';
import '../../data/apiClient/api.dart';
import '../../tstts.dart';
import '../../widgets/button/button.dart';
import '../Language Selection/language_controller.dart';
import '../bottomnav/controller/bottomnav_controller.dart';
import 'cart_controller.dart';

class CartPage extends StatelessWidget {
  GetStorage Box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    final BottomNavController bottomNavController =
        Get.put(BottomNavController());

    final Map<String, dynamic> item;
    final token = GetStorage().read('access_token');
    String selectedType = Box.read('selectedButton') ?? '';
    String effectiveType = selectedType;

    if (effectiveType == 'promotion') {
      effectiveType = 'grocery';
    }

    List<Map<String, dynamic>> filteredCartItems =
        cartController.getCartItems().where((item) {
      return item['type'] ==
          effectiveType; // Use the effective type for filtering
    }).toList();
    double calculateTotal(List<Map<String, dynamic>> items) {
      return double.parse(
        items.fold(
          0.00,
              (sum, item) {
            double price = double.tryParse(item['price'].toString()) ?? 0.00;
            int quantity = int.tryParse(item['quantity'].toString()) ?? 1;
            return sum + (price * quantity);
          },
        ).toStringAsFixed(2),
      );
    }

    double totalPrice = 0;

// Determine which list of items to use
    final cartItems = token == null ? filteredCartItems : cartController.getCartItems();
    totalPrice = cartItems.fold(0, (sum, item) {
      final servicePrice = item['service'] != null
          ? item['service'].map((service) {
        final price = (service is Map && service['price'] != null)
            ? double.tryParse(service['price'].toString()) ?? 0
            : 0;
        return price;
      }).reduce((value, element) => value + element)
          : 0;
      return sum + servicePrice;
    });

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
        future: cartController.fetchCartItems(), // Fetch the cart items
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // else if (snapshot.hasError) {
          //   return Center(child: Text('Error: ${snapshot.error}'));
          // }
          else {
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
                      languagecontroller.emptyText,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20.h),
                    Button(
                      size: Size(160.w, 50.h),
                      color: Color(0xFFEB1C23),
                      text: Text(
                        languagecontroller.startText,
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      ontap: () {
                        bottomNavController.updateIndex(0);
                        Get.off(() => CustomBottomNavBar());
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
                        itemCount: token == null
                            ? filteredCartItems.length
                            : cartController.getCartItems().length,
                        itemBuilder: (context, index) {
                          final item = token == null
                              ? filteredCartItems[index]
                              : cartController.getCartItems()[index];
                          final int productId = item['product_id'];
                          return IntrinsicHeight(
                            child: Container(
                              //height: 114.h,
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
                                        child: Center(
                                          child: item['image'] != null &&
                                                  item['image'].isNotEmpty
                                              ? Image.network(
                                                  '${Api.ImageUrl}/products/${item['image']}',
                                                  width: 80.w,
                                                  height: 80.h,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Icon(
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
                                              bottomRight:
                                                  Radius.circular(14.r),
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
                                              final productId =
                                                  item['product_id'];

                                              if (token != null) {
                                                cartController
                                                    .removeItemFromCart(
                                                        productId);
                                              } else {
                                                cartController.removeFromCart(
                                                    item['name'],
                                                    (item['price'] ?? 0)
                                                        .toString(),
                                                    item['image'],
                                                    item['type']);
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

                                        if (Box.read('selectedButton') ==
                                            'laundry') ...[
                                          if (Box.read('access_token') !=
                                              null) ...[
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: (item['services']
                                                              as List<
                                                                  dynamic>? ??
                                                          [])
                                                      .map<Widget>((service) {
                                                    // Extract service name from the nested structure
                                                    final serviceName = (service
                                                                is Map &&
                                                            service['service'] !=
                                                                null &&
                                                            service['service']
                                                                    ['name'] !=
                                                                null)
                                                        ? service['service']
                                                            ['name']
                                                        : 'Unknown Service';
                                                    print(
                                                        'Services: ${item['services']}');
                                                    return Text(
                                                      serviceName,
                                                      style: TextStyle(
                                                          fontSize: 14.sp),
                                                    );
                                                  }).toList(),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: (item['services']
                                                              as List<
                                                                  dynamic>? ??
                                                          [])
                                                      .map<Widget>((service) {
                                                    // Extract service name from the nested structure
                                                    final servicePrice = (service
                                                                is Map &&
                                                            service['service'] !=
                                                                null &&
                                                            service['price'] !=
                                                                null)
                                                        ? service['price']
                                                        : 'Unknown Service';
                                                    print(
                                                        'Services: ${item['services']}');
                                                    return Text(
                                                      "\AED ${servicePrice}",
                                                      style: TextStyle(
                                                          fontSize: 14.sp),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (Box.read('access_token') ==
                                              null) ...[
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: (item['service']
                                                              as List<dynamic>?)
                                                          ?.map<Widget>(
                                                              (service) {
                                                        final serviceName = (service
                                                                    is Map &&
                                                                service != null)
                                                            ? service['name']
                                                            : 'Unknown Service';
                                                        return Text(
                                                          serviceName,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        );
                                                      }).toList() ??
                                                      [
                                                        Text(
                                                            'No Services Available')
                                                      ],
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: (item['service']
                                                              as List<dynamic>?)
                                                          ?.map<Widget>(
                                                              (service) {
                                                        final servicePrice =
                                                            (service is Map &&
                                                                    service !=
                                                                        null)
                                                                ? service[
                                                                    'price']
                                                                : 'Unknown Service';
                                                        return Text(
                                                          "\AED ${servicePrice}",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        );
                                                      }).toList() ??
                                                      [
                                                        Text(
                                                            'No Services Available')
                                                      ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],

                                        // if (Box.read('selectedButton') == 'laundry') ...[
                                        //   Text('${item['services'].join(', ')}', style: TextStyle(fontSize: 16)),
                                        // ],

                                        Visibility(
                                          visible: Box.read('selectedButton') !=
                                              'laundry',
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\AED ${item['price'] ?? '0'}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Decrement Button
                                                    Container(
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        color: Colors.white,
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.remove,
                                                          color:
                                                              (item['quantity'] ??
                                                                          0) >
                                                                      1
                                                                  ? Colors.red
                                                                      .shade600
                                                                  : Colors.grey,
                                                        ),
                                                          onPressed: () {
                                                            if ((item['quantity'] ?? 0) > 1) {
                                                              // Reduce the quantity by 1
                                                              cartController.updateQuantity(item['product_id'], -1);
                                                            } else {
                                                              // If quantity is 1, remove the item from the cart
                                                              final productId = item['product_id'];
                                                              if (token != null) {
                                                                cartController.removeItemFromCart(productId);
                                                              } else {
                                                                cartController.removeFromCart(
                                                                  item['name'],
                                                                  (item['price'] ?? 0)
                                                                      .toString(),
                                                                  item['image'],
                                                                  item['type'],
                                                                );
                                                              }
                                                            }}
                                                      ),
                                                    ),

                                                    SizedBox(width: 5.w),

                                                    // Display Quantity
                                                    Text(
                                                      '${item['quantity'] ?? 0}',
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),

                                                    SizedBox(width: 5.w),

                                                    // Increment Button
                                                    Container(
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        color: Colors.white,
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: Colors
                                                              .green.shade800,
                                                        ),
                                                        onPressed: () {
                                                          cartController
                                                              .updateQuantity(
                                                                  productId, 1);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                            Text(languagecontroller.totalText,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp)),
                            SizedBox(width: 10),
                            Obx(() {
                              return Text(
                                "\AED ${cartController.total_amount.value}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: Colors.green.shade800,
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                      ],
                      if (cartController.getCartItems().isNotEmpty) ...[
                        if (token == null) ...[
                          if (Box.read('selectedButton') == 'grocery') ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  languagecontroller.totalText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "\AED ${calculateTotal(filteredCartItems)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ],
                      if (cartController.getCartItems().isNotEmpty) ...[
                        if (token == null) ...[
                          if (Box.read('selectedButton') == 'laundry') ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  languagecontroller.totalText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "\AED ${totalPrice}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ],

                      // Show the Continue button if there are items in the cart
                      if (cartController.getCartItems().isNotEmpty) ...[
                        Button(
                          color: Color(0xFFEB1C23),
                          size: Size(340.w, 45.h),
                          text: Text(
                            languagecontroller.continueText,
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.white),
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
                      languagecontroller.emptyText,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20.h),
                    Button(
                      size: Size(160.w, 50.h),
                      color: Color(0xFFEB1C23),
                      text: Text(
                        languagecontroller.startText,
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      ontap: () {
                        bottomNavController.updateIndex(0);
                        Get.off(() => CustomBottomNavBar());
                      },
                    )
                  ],
                ); // Return an empty message if there's no data
              }
            });
          }
        },
      ),
    );
  }
}
