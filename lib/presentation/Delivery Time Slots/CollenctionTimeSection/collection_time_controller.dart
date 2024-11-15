import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Cart/cart_controller.dart';
import '../PaymentSection/Payment_Section.dart';

class CollectionTimeController extends GetxController {
  var selectedIndex = 0.obs;
  var todayCheckedList = List.filled(24, false).obs;
  var tomorrowCheckedList = List.filled(24, false).obs;
  var showPaymentSection = false.obs;
  var collectionTimeSlot = ''.obs;
  var collectionDay = ''.obs;
  var showDeliverySection = false.obs;

  final CartController cartController = Get.put(CartController());

  String getFormattedDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  String get today => getFormattedDate(DateTime.now());
  String get tomorrow => getFormattedDate(DateTime.now().add(Duration(days: 1)));

  var todayItems = <String>[
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
    collectionDay.value = selectedIndex.value == 0 ? 'Today' : 'Tomorrow';
    print('Day: ${collectionDay.value}');
  }

  void toggleCheckbox(int index) {
    final listToCheck = selectedIndex.value == 0 ? todayCheckedList : tomorrowCheckedList;
    listToCheck.assignAll(List.filled(listToCheck.length, false));
    listToCheck[index] = true;

    collectionTimeSlot.value = selectedIndex.value == 0 ? todayItems[index] : tomorrowItems[index];
    print('Selected Collection Time Slot: ${collectionTimeSlot.value}');
  }

  void goToDeliveryTimeSection() {
    if (todayCheckedList.contains(true) || tomorrowCheckedList.contains(true)) {
      showDeliverySection.value = true;
    } else {
      // Handle case when no time slot is selected
    }
  }

  void saveSelectedDeliveryTime() {
    print('Selected collection day: ${collectionDay.value}');
    print('Selected time: ${collectionTimeSlot.value}');
  }
}

