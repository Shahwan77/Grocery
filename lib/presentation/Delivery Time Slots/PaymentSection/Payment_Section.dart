import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/Delivery%20Time%20Slots/PaymentSection/payment_controller.dart';
import '../../../widgets/button/button.dart';
import '../../Cart/cart_controller.dart';
import '../DeliveryTimeSection/delivery_time_controller.dart';

class PaymentSection extends StatelessWidget {
  final String selectedDay;
  final String selectedTimeSlot;
  final List<dynamic> cartItems;

  const PaymentSection({
    super.key,
    required this.cartItems,
    required this.selectedDay,
    required this.selectedTimeSlot,
  });

  @override
  Widget build(BuildContext context) {
    final PaymentMethodController paymentMethodController =
    Get.put(PaymentMethodController());
    final DeliveryTimeController deliveryTimeController =
    Get.put(DeliveryTimeController());

    final List<String> paybycashItems = [
      'NO Change Needed',
      'AED 50',
      'AED 100',
      'AED 200'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Payment Method',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Obx(() => GestureDetector(
              onTap: () {
                paymentMethodController.updateSelectedIndex(0);
              },
              child: Container(
                width: 110.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: paymentMethodController.selectedIndex.value == 0
                      ? Color(0xFFEB1C23)
                      : Colors.white,
                  border: Border.all(
                      color:
                      paymentMethodController.selectedIndex.value == 0
                          ? Colors.transparent
                          : Colors.black),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      'Pay By Cash',
                      style: TextStyle(
                        color:
                        paymentMethodController.selectedIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      'Available',
                      style: TextStyle(
                        color:
                        paymentMethodController.selectedIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(width: 10.w),
            Obx(() => GestureDetector(
              onTap: () {
                paymentMethodController.updateSelectedIndex(1);
              },
              child: Container(
                width: 110.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: paymentMethodController.selectedIndex.value == 1
                      ? Color(0xFFEB1C23)
                      : Colors.white,
                  border: Border.all(
                      color:
                      paymentMethodController.selectedIndex.value == 1
                          ? Colors.transparent
                          : Colors.black),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      'Bring Card Reader',
                      style: TextStyle(
                        color:
                        paymentMethodController.selectedIndex.value == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      'Available',
                      style: TextStyle(
                        color:
                        paymentMethodController.selectedIndex.value == 1
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
          final items = paymentMethodController.selectedIndex.value == 0
              ? paybycashItems
              : [];

          return Column(
            children: List.generate(items.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: ListTile(
                    title:
                    Text(items[index], style: TextStyle(fontSize: 14.sp)),
                    trailing: Obx(() {
                      final isChecked =
                      paymentMethodController.cashCheckedList[index];
                      return Container(
                        height: 30.h,
                        width: 34.w,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            paymentMethodController.toggleCheckbox(index);
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
                      paymentMethodController.toggleCheckbox(index);
                    },
                  ),
                ),
              );
            }),
          );
        }),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              size: Size(80.w, 44.h),
              color:Color(0xFFEB1C23),
              text: Text('Prev', style: TextStyle(color: Colors.white)),
              ontap: () {
                deliveryTimeController.backToDeliveryTime();
              },
            ),
            SizedBox(width: 18.w),
            Button(
              size: Size(100.w, 44.h),
              color: Color(0xFFEB1C23),
              text: Text('Confirm', style: TextStyle(color: Colors.white)),
              ontap: () {
                paymentMethodController.postOrder();
              },
            ),
          ],
        ),
      ],
    );
  }
}
