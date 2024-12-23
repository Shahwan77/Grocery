import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Cart/cart_controller.dart';
import '../PaymentSection/Payment_Section.dart';

class DeliveryTimeController extends GetxController {
  var selectedIndex = 0.obs;
  var todayCheckedList = List.filled(25, false).obs;
  var tomorrowCheckedList = List.filled(24, false).obs;
  var showPaymentSection = false.obs;
  var selectedTimeSlot = ''.obs;
  var selectedDay = ''.obs;

  String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String get today => getFormattedDate(DateTime.now());
  String get tomorrow => getFormattedDate(DateTime.now().add(Duration(days: 1)));

  final CartController cartController = Get.put(CartController());

  var todayItems = <String>[
    'Deliver Now',
    '12:00 AM - 1:00 AM', '1:00 AM - 2:00 AM', '2:00 AM - 3:00 AM',
    '3:00 AM - 4:00 AM', '4:00 AM - 5:00 AM', '5:00 AM - 6:00 AM',
    '6:00 AM - 7:00 AM', '7:00 AM - 8:00 AM', '8:00 AM - 9:00 AM',
    '9:00 AM - 10:00 AM', '10:00 AM - 11:00 AM', '11:00 AM - 12:00 PM',
    '12:00 PM - 1:00 PM', '1:00 PM - 2:00 PM', '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM', '4:00 PM - 5:00 PM', '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM', '7:00 PM - 8:00 PM', '8:00 PM - 9:00 PM',
    '9:00 PM - 10:00 PM', '10:00 PM - 11:00 PM', '11:00 PM - 12:00 AM',
  ].obs;

  var tomorrowItems = <String>[
    '12:00 AM - 1:00 AM', '1:00 AM - 2:00 AM', '2:00 AM - 3:00 AM',
    '3:00 AM - 4:00 AM', '4:00 AM - 5:00 AM', '5:00 AM - 6:00 AM',
    '6:00 AM - 7:00 AM', '7:00 AM - 8:00 AM', '8:00 AM - 9:00 AM',
    '9:00 AM - 10:00 AM', '10:00 AM - 11:00 AM', '11:00 AM - 12:00 PM',
    '12:00 PM - 1:00 PM', '1:00 PM - 2:00 PM', '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM', '4:00 PM - 5:00 PM', '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM', '7:00 PM - 8:00 PM', '8:00 PM - 9:00 PM',
    '9:00 PM - 10:00 PM', '10:00 PM - 11:00 PM', '11:00 PM - 12:00 AM',
  ].obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedDay.value = selectedIndex.value == 0 ? 'Today' : 'Tomorrow';
  }

  void toggleCheckbox(int index) {
    if (selectedIndex.value == 0) { // Today
      if (index == 0) {
        // If "Deliver Now" is selected or deselected
        if (!todayCheckedList[index]) {
          // Set "Deliver Now" with the current time range
          todayCheckedList.assignAll(List.filled(todayItems.length, false));
          DateTime currentTime = DateTime.now();
          String formattedTime = DateFormat('hh:mm a').format(currentTime);
          selectedTimeSlot.value = '$formattedTime - $formattedTime'; // '12:00 AM - 12:00 AM'
        } else {
          selectedTimeSlot.value = ''; // Clear the time slot if it's deselected
        }
        todayCheckedList[index] = !todayCheckedList[index];
      } else {
        todayCheckedList.assignAll(List.filled(todayItems.length, false));
        todayCheckedList[index] = true;
        selectedTimeSlot.value = todayItems[index];
      }
    } else if (selectedIndex.value == 1) { // Tomorrow
      if (index == 0) {
        // If "Deliver Now" is selected or deselected for tomorrow
        tomorrowCheckedList.assignAll(List.filled(tomorrowItems.length, false));
        if (!tomorrowCheckedList[index]) {
          // Set "Deliver Now" with the current time range
          DateTime currentTime = DateTime.now().add(Duration(days: 1));
          String formattedTime = DateFormat('hh:mm a').format(currentTime);
          selectedTimeSlot.value = '$formattedTime - $formattedTime'; // '12:00 AM - 12:00 AM'
        } else {
          selectedTimeSlot.value = ''; // Clear the time slot if it's deselected
        }
        tomorrowCheckedList[index] = !tomorrowCheckedList[index];
      } else {
        tomorrowCheckedList.assignAll(List.filled(tomorrowItems.length, false));
        tomorrowCheckedList[index] = true;
        selectedTimeSlot.value = tomorrowItems[index];
      }
    }
  }
  void backToDeliveryTime() {
    showPaymentSection.value = false;
  }
  void goToPaymentSection() {
    if (todayCheckedList.contains(true) || tomorrowCheckedList.contains(true)) {
      showPaymentSection.value = true;
    }
  }

  void saveSelectedDeliveryTime() {
    selectedDay.value = selectedIndex.value == 0 ? 'Today' : 'Tomorrow';
    print('Selected delivery day: ${selectedDay.value}');
    print('Selected time: ${selectedTimeSlot.value}');
  }
}
