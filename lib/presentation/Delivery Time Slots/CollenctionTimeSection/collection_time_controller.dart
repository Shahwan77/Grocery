import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Cart/cart_controller.dart';
import '../PaymentSection/Payment_Section.dart';

class CollectionTimeController extends GetxController {
  var selectedIndex = 0.obs;
  var todayCheckedList = [false, false, false].obs;
  var tomorrowCheckedList = [false, false, false].obs;
  var isCheckedList = [false, false, false].obs;
  var showPaymentSection = false.obs;
  var collectionTimeSlot = ''.obs;
  var collectionDay = ''.obs;
  var showDeliverySection = false.obs;
  String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String get today => getFormattedDate(DateTime.now());

  String get tomorrow => getFormattedDate(DateTime.now().add(Duration(days: 1)));

  final CartController cartController = Get.put(CartController());

  var todayItems = <String>[
    '2:37 PM - 3:37 PM',
    '3:37 PM - 4:37 PM',
    '4:37 PM - 5:37 PM'
  ].obs;

  var tomorrowItems = <String>[
    '2:30 PM - 3:30 PM',
    '3:30 PM - 4:30 PM',
    '4:30 PM - 5:30 PM'
  ].obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    print('Updated selectedIndex: $selectedIndex');

    if (selectedIndex.value == 0) {
      collectionDay.value = 'Today'; // Payment method
    } else {
      collectionDay.value = 'Tomorrow'; // Payment method
    }
    print('Day: ${collectionDay.value}');
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
      collectionTimeSlot.value = todayItems[index]; // Store the selected time slot
    } else {
      for (int i = 0; i < todayCheckedList.length; i++) {
        todayCheckedList[i] = false;
      }
      for (int i = 0; i < tomorrowCheckedList.length; i++) {
        tomorrowCheckedList[i] = false;
      }
      tomorrowCheckedList[index] = true;
      collectionTimeSlot.value = tomorrowItems[index]; // Store the selected time slot
    }
    print('Selected Collection Time Slot: ${collectionTimeSlot.value}');
  }

  void goToDeliveryTimeSection() {
    if (todayCheckedList.contains(true) || tomorrowCheckedList.contains(true)) {
      showDeliverySection.value = true;
      // You can navigate to the PaymentSection here
    } else {
      // Handle the case where no time slot is selected
    }
  }
  // void goToDeliveryTime() {
  //   showPaymentSection.value = false; // Hide payment section
  //   // showDeliverySection.value = true;  // Show delivery section
  // }
  void backToCollectionTime() {
    showPaymentSection.value = false;
  }

  void saveSelectedDeliveryTime() {
    if (selectedIndex.value == 0) {
      collectionDay.value = 'Today'; // Payment method
    } else {
      collectionDay.value = 'Tomorrow'; // Payment method
    }

    print('Selected collection day: ${collectionDay.value}');
    print('Selected time: ${collectionTimeSlot.value}');
  }
}
