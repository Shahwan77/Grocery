import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/button/button.dart';
import '../../Cart/cart_controller.dart';
import '../../Language Selection/language_controller.dart';
import '../../order_details/order_details.dart';
import 'delivery_time_controller.dart';

class DeliveryTimeSection extends StatelessWidget {
  final List<dynamic> cartItems;
  final String collectionDay;
  final String collectionTimeSlot;
  const DeliveryTimeSection({super.key, required this.cartItems,
    required this.collectionDay, required this.collectionTimeSlot,
  });

  @override
  Widget build(BuildContext context) {
    final DeliveryTimeController deliveryTimeController = Get.put(DeliveryTimeController());
    final CartController cartController = Get.put(CartController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languagecontroller.datetimeText,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            // 'Today' Button
            Obx(() => GestureDetector(
              onTap: () {
                deliveryTimeController.updateSelectedIndex(0);
              },
              child: Container(
                width: 110.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: deliveryTimeController.selectedIndex.value == 0
                      ? Color(0xFFEB1C23)
                      : Colors.white,
                  border: Border.all(
                    color: deliveryTimeController.selectedIndex.value == 0
                        ? Colors.transparent
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                     languagecontroller.todayText,
                      style: TextStyle(
                        color: deliveryTimeController.selectedIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                     deliveryTimeController.today, // Show formatted date for today
                      style: TextStyle(
                        color: deliveryTimeController.selectedIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )),

            SizedBox(width: 10.w),

            // 'Tomorrow' Button
            Obx(() => GestureDetector(
              onTap: () {
                deliveryTimeController.updateSelectedIndex(1);
              },
              child: Container(
                width: 110.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: deliveryTimeController.selectedIndex.value == 1
                      ? Color(0xFFEB1C23)
                      : Colors.white,
                  border: Border.all(
                    color: deliveryTimeController.selectedIndex.value == 1
                        ? Colors.transparent
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      languagecontroller.tomorrowText,
                      style: TextStyle(
                        color: deliveryTimeController.selectedIndex.value == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                     deliveryTimeController.tomorrow, // Show formatted date for tomorrow
                      style: TextStyle(
                        color: deliveryTimeController.selectedIndex.value == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
        SizedBox(height: 20.h),
        Obx(() {
          // Determine which items and checkboxes to display based on the selectedIndex
          final items = deliveryTimeController.selectedIndex.value == 0
              ? deliveryTimeController.todayItems
              : deliveryTimeController.tomorrowItems;
          final isCheckedList = deliveryTimeController.selectedIndex.value == 0
              ? deliveryTimeController.todayCheckedList
              : deliveryTimeController.tomorrowCheckedList;

          return Container(
            height: 300.h, // Set the desired height for the scrollable list
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevents ListView from scrolling independently
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: ListTile(
                          title: Text(items[index], style: TextStyle(fontSize: 14.sp)),
                          trailing: Obx(() {
                            return Container(
                              height: 30.h,
                              width: 34.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Checkbox(
                                value: isCheckedList[index],
                                onChanged: (value) {
                                  deliveryTimeController.toggleCheckbox(index);
                                },
                                activeColor: Colors.transparent,
                                checkColor: Color(0xFFEB1C23),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r)),
                                side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide.none,
                                ),
                              ),
                            );
                          }),
                          onTap: () {
                            deliveryTimeController.toggleCheckbox(index);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }),

        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              text: Text(
                languagecontroller.nextText,
                style: TextStyle(color: Colors.white),
              ),
              ontap: () {
                // List<dynamic> cartItems = cartController.getCartItems();
                //
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
                deliveryTimeController.saveSelectedDeliveryTime();
                deliveryTimeController.goToPaymentSection();
              },
            ),
          ],
        ),
      ],
    );
  }
}
