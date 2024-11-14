import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Cart/cart_controller.dart';
import '../PaymentSection/Payment_Section.dart';

class DeliveryTimeController extends GetxController {
  var selectedIndex = 0.obs;
  var todayCheckedList = [false, false, false].obs;
  var tomorrowCheckedList = [false, false, false].obs;
  var isCheckedList = [false, false, false].obs;
  var showPaymentSection = false.obs;
  var showDelivery = false.obs;
  var selectedTimeSlot = ''.obs;
  var selectedDay = ''.obs;

  String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String get today => getFormattedDate(DateTime.now());

  String get tomorrow => getFormattedDate(DateTime.now().add(Duration(days: 1)));

  final CartController cartController = Get.put(CartController());

  var todayItems = <String>[
    '12:00 AM - 1:00 AM',
    '1:00 AM - 2:00 AM',
    '2:00 AM - 3:00 AM',
  ].obs;

  var tomorrowItems = <String>[
    '12:00 AM - 1:00 AM',
    '1:00 AM - 2:00 AM',
    '2:00 AM - 3:00 AM',
  ].obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    print('Updated selectedIndex: $selectedIndex');

    if (selectedIndex.value == 0) {
      selectedDay.value = 'Today'; // Payment method
    } else {
      selectedDay.value = 'Tomorrow'; // Payment method
    }
    print('Day: ${selectedDay.value}');
  }

  void toggleCheckbox(int index) {
    if (selectedIndex.value == 0) {
      for (int i = 0; i < tomorrowCheckedList.length; i++) {
        tomorrowCheckedList[i] = false;
      }
      for (int i = 0; i < todayCheckedList.length; i++) {
        todayCheckedList[i] = false;
      }
      todayCheckedList[index] = true;
      selectedTimeSlot.value = todayItems[index]; // Store the selected time slot
    } else {
      for (int i = 0; i < todayCheckedList.length; i++) {
        todayCheckedList[i] = false;
      }
      for (int i = 0; i < tomorrowCheckedList.length; i++) {
        tomorrowCheckedList[i] = false;
      }
      tomorrowCheckedList[index] = true;
      selectedTimeSlot.value = tomorrowItems[index]; // Store the selected time slot
    }
    print('Selected Delivery Time Slot: ${selectedTimeSlot.value}');
  }

  void goToPaymentSection() {
    if (todayCheckedList.contains(true) || tomorrowCheckedList.contains(true)) {
      showPaymentSection.value = true;
      // You can navigate to the PaymentSection here
    } else {
      // Handle the case where no time slot is selected
    }
  }

  void backToDeliveryTime() {
    showPaymentSection.value = false;
  }

  void saveSelectedDeliveryTime() {
    if (selectedIndex.value == 0) {
      selectedDay.value = 'Today'; // Payment method
    } else {
      selectedDay.value = 'Tomorrow'; // Payment method
    }

    print('Selected delivery day: ${selectedDay.value}');
    print('Selected time: ${selectedTimeSlot.value}');
  }
}
