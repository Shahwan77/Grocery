import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Cart/cart_controller.dart';
import 'organic_model.dart';

class Organic extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(9.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 20.0, // Space between columns
        mainAxisSpacing: 40.0, // Space between rows
        mainAxisExtent: 240,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 240, // Container height
              width: 190, // Container width
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.favorite_border,
                            color: Colors.green),
                        Icon(Icons.info_outline,
                            color: Colors.green),
                      ],
                    ),
                  ),
                  Center(
                    child: Image.network(
                      imageUrls[
                      index], // Use imagePath from model
                      fit: BoxFit.cover,
                      height: 100, // Image height
                      width: 100, // Image width
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      text1[index],
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Price1[index],
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              cartController.toggleCart(
                                text1[index],
                                Price1[index],
                                imageUrls[index],
                              );
                              Get.snackbar(
                                cartController.isInCart(text1[index])
                                    ? 'Added to Cart'
                                    : 'Removed from Cart',
                                '${text1[index]} has been ${cartController.isInCart(text1[index]) ? 'added to' : 'removed from'} your cart.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: cartController
                                  .isInCart(text1[index])
                                  ? Colors.green.shade800
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ]
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
