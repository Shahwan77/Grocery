// ice_cream_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Cart/cart_controller.dart';
import 'ice_models.dart';

class IceCreamPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'ICE CREAM COLLECTION',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 20.0, // Space between columns
            mainAxisSpacing: 40.0, // Space between rows
            mainAxisExtent: 212
        ),
        itemCount:iceCreamItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 170.h, // Container height
                width: 160.w,  // Container width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.r,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.favorite_border, color: Colors.green),
                          Icon(Icons.info_outline, color: Colors.green),
                        ],
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        iceCreamItems[index].imagePath,
                        fit: BoxFit.cover,
                        height: 80.h, // Image height
                        width: 80.w,  // Image width
                      ),
                    ),
                    Text(
                      iceCreamItems[index].name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start, // Ensures text is aligned consistently
                    ),
                    // Price and Cart Icon
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            iceCreamItems[index].price,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Obx(() {
                            return GestureDetector(
                              onTap: () {
                                cartController.toggleCart(
                                  iceCreamItems[index].name,
                                  iceCreamItems[index].price,
                                  iceCreamItems[index].imagePath,
                                );                                Get.snackbar(
                                  cartController.isInCart(iceCreamItems[index].name)
                                      ? 'Added to Cart'
                                      : 'Removed from Cart',
                                  '${iceCreamItems[index].name} has been ${cartController.isInCart(iceCreamItems[index].name) ? 'added to' : 'removed from'} your cart.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: cartController.isInCart(iceCreamItems[index].name)
                                    ? Colors.green.shade800
                                    : Colors.grey,
                              ),
                            );
                          }),                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
