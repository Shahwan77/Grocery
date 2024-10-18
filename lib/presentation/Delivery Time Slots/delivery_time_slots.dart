import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Delivery%20Time%20Slots/DeliveryTimeSection/Deliverytime_Section.dart';
import 'package:grocery/presentation/Delivery%20Time%20Slots/PaymentSection/Payment_Section.dart';
import 'package:grocery/presentation/Delivery%20Time%20Slots/DeliveryTimeSection/delivery_time_controller.dart';
import 'package:grocery/presentation/Delivery%20Time%20Slots/deliverytime_slots_controller.dart';

import 'CollenctionTimeSection/Collectiontime_Section.dart';
import 'CollenctionTimeSection/collection_time_controller.dart';

class DeliveryTimeSlots extends StatelessWidget {
  final List<dynamic> cartItems;
  const DeliveryTimeSlots({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final DeliveryTimeController deliveryTimeController =
        Get.put(DeliveryTimeController());
    final DeliveryTimeSlotsController deliveryTimeSlotsController =
        Get.put(DeliveryTimeSlotsController());
    final CollectionTimeController collectionTimeController =
        Get.put(CollectionTimeController());

    final GetStorage box = GetStorage();
    final selectedButton = box.read('selectedButton');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
              height: 22.h,
              width: 26.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r)),
              child: Center(
                  child: Icon(Icons.arrow_back_ios_rounded,
                      color: Color(0xFFEB1C23), size: 20.sp))),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Color(0xFFEB1C23),
        title: Text(
          'Delivery Time Slots',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        child: selectedButton == 'laundry'
            ? Obx(() {
                deliveryTimeSlotsController.saveSelectedDeliveryTimeSlots();
                if (deliveryTimeController.showPaymentSection.value) {
                  return PaymentSection(
                    cartItems: cartItems,
                    selectedDay: deliveryTimeController.selectedDay.value,
                    selectedTimeSlot:
                        deliveryTimeController.selectedTimeSlot.value,
                  );
                } else if (collectionTimeController.showDeliverySection.value) {
                  return DeliveryTimeSection(
                    cartItems: cartItems,
                    collectionDay: collectionTimeController.collectionDay.value,
                    collectionTimeSlot:
                        collectionTimeController.collectionTimeSlot.value,
                  );
                } else {
                  return CollectionTimeSection(cartItems: cartItems);
                  // Otherwise, show DeliveryTimeSection
                }
              })
            : Obx(() {
                deliveryTimeSlotsController.saveSelectedDeliveryTimeSlots();
                if (deliveryTimeController.showPaymentSection.value) {
                  return PaymentSection(
                    cartItems: cartItems,
                    selectedDay: deliveryTimeController.selectedDay.value,
                    selectedTimeSlot:
                        deliveryTimeController.selectedTimeSlot.value,
                  );
                } else {
                  return DeliveryTimeSection(
                    cartItems: cartItems,
                    collectionDay: collectionTimeController.collectionDay.value,
                    collectionTimeSlot:
                        collectionTimeController.collectionTimeSlot.value,
                  ); // Otherwise, show DeliveryTimeSection
                }
              }),
      ),
    );
  }
}
