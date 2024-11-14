import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery/kkk.dart';

import '../order_details/my_ordrs.dart';
import 'add_to_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final int id;
  final int itemId;
  final String itemName;
  final String itemImage;
  final double? itemPrice;

  ProductDetailPage({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.itemImage,
    this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController(itemId,id));

    // Set the item price here
    productController.setItemPrice(itemPrice);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: Color(0xFFEB1C23),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              itemImage,
              height: 146.h,
            ),
            SizedBox(height: 14.h),
            Text(
              itemName,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 14.h),
            Text(
              'AED ${itemPrice}',
              style: TextStyle(fontSize:  17.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Container(
                      width: 28.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                          color: Color(0xFFEB1C23),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Icon(Icons.remove, color: Colors.white)),
                  onPressed: productController.decrementQuantity,
                ),
                SizedBox(width: 4.w),
                Obx(() => Container(
                  width: 50.w,
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      '${productController.quantity.value}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                )),
                SizedBox(width: 4.w),
                IconButton(
                  icon: Container(
                      width: 28.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                          color: Color(0xFFEB1C23),
                          borderRadius: BorderRadius.circular(28.r)
                      ),
                      child: Icon(Icons.add, color: Colors.white)),
                  onPressed: productController.incrementQuantity,
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Obx(() => CheckboxListTile(
              value: productController.isDefaultReplacement.value,
              onChanged: (bool? value) {
                productController.toggleDefaultReplacement();
              },
              title: Text(
                'Make this my default replacement when Almarai Fresh Low Fat Milk 2 L is out of stock in future orders',
                style: TextStyle(fontSize: 12.sp),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            )),
            Spacer(),
            Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEB1C23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
              ),
              onPressed: () {
                if (!productController.isDefaultReplacement.value) {
                  Get.snackbar(
                    'Validation Error',
                    'Please check the replacement option to continue.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  productController.postReplacementOrder();
                  // Get.back(result: OrderPage());
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add to basket',
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                  Text(
                    'AED ${productController.totalPrice.toStringAsFixed(2)}', // Display total price
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
