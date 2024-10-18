import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/button/button.dart';
import '../../Cart/cart_controller.dart';
import '../../order_details/order_details.dart';
import 'collection_time_controller.dart';

class CollectionTimeSection extends StatelessWidget {
  final List<dynamic> cartItems;
  const CollectionTimeSection({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final CollectionTimeController collectionTimeController = Get.put(CollectionTimeController());
    final CartController cartController = Get.put(CartController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Collection Date & Timeslots',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            // 'Today' Button
            Obx(() => GestureDetector(
              onTap: () {
                collectionTimeController.updateSelectedIndex(0);
              },
              child: Container(
                width: 110.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: collectionTimeController.selectedIndex.value == 0
                      ? Color(0xFFEB1C23)
                      : Colors.white,
                  border: Border.all(
                    color: collectionTimeController.selectedIndex.value == 0
                        ? Colors.transparent
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: collectionTimeController.selectedIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      collectionTimeController.today, // Show formatted date for today
                      style: TextStyle(
                        color: collectionTimeController.selectedIndex.value == 0
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
                collectionTimeController.updateSelectedIndex(1);
              },
              child: Container(
                width: 110.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: collectionTimeController.selectedIndex.value == 1
                      ? Color(0xFFEB1C23)
                      : Colors.white,
                  border: Border.all(
                    color: collectionTimeController.selectedIndex.value == 1
                        ? Colors.transparent
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      'Tomorrow',
                      style: TextStyle(
                        color: collectionTimeController.selectedIndex.value == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      collectionTimeController.tomorrow, // Show formatted date for tomorrow
                      style: TextStyle(
                        color: collectionTimeController.selectedIndex.value == 1
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
          final items = collectionTimeController.selectedIndex.value == 0
              ? collectionTimeController.todayItems
              : collectionTimeController.tomorrowItems;
          final isCheckedList = collectionTimeController.selectedIndex.value == 0
              ? collectionTimeController.todayCheckedList
              : collectionTimeController.tomorrowCheckedList;

          return ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
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
                              collectionTimeController.toggleCheckbox(index);
                            },
                            activeColor: Colors.transparent,
                            checkColor:Color(0xFFEB1C23),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide.none,
                            ),
                          ),
                        );
                      }),
                      onTap: () {
                        collectionTimeController.toggleCheckbox(index);
                      },
                    ),
                  ),
                ],
              );
            },
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
                'Prev',
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
                'Next',
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
                collectionTimeController.saveSelectedDeliveryTime();
                collectionTimeController.goToDeliveryTimeSection();
              },
            ),
          ],
        ),
      ],
    );
  }
}
