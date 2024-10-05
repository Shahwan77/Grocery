// ListTile(
//                       title: Text(
//                         items[index],
//                         style: TextStyle(fontSize: 14.sp),
//                       ),
//                       trailing: Obx(() => Visibility(
//                         visible: deliveryTimeController.selectedIndex.value == 0 ||
//                             deliveryTimeController.selectedIndex.value == 1,
//                         child: Container(
//                           height: 30.h,
//                           width: 34.w,
//                           decoration: BoxDecoration(
//                               color: Colors.grey.shade100,
//                               borderRadius: BorderRadius.circular(30.r)),
//                           child: Checkbox(
//                             value: deliveryTimeController.isCheckedList[index],
//                             onChanged: (value) {
//                               deliveryTimeController.toggleCheckbox(index);
//                             },
//                             activeColor: Colors.transparent,
//                             checkColor: Colors.red,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.r)),
//                             side: MaterialStateBorderSide.resolveWith(
//                                   (states) => BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       )),
//                       onTap: () {
//                         deliveryTimeController.toggleCheckbox(index);
//                       },
//                     ),



// import 'package:get/get.dart';
//
// class DeliveryTimeSlotsController extends GetxController {
//   var selectedIndex = 0.obs;
//   var isCheckedList = [false, false, false].obs;
//   var showPaymentSection = false.obs; // To track if payment section is shown
//
//   void updateSelectedIndex(int index) {
//     selectedIndex.value = index;
//   }
//
//   void toggleCheckbox(int index) {
//     isCheckedList[index] = !isCheckedList[index];
//   }
//
//   void goToPaymentSection() {
//     showPaymentSection.value = true;
//   }
//
//   void backToDeliveryTime() {
//     showPaymentSection.value = false;
//   }
// }
