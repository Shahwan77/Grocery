import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:grocery/presentation/Cart/cart_controller.dart';
import 'package:grocery/presentation/Delivery%20Time%20Slots/CollenctionTimeSection/Collectiontime_Section.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/order_model.dart';
import '../../bottomnav/controller/bottomnav_controller.dart';
import '../CollenctionTimeSection/collection_time_controller.dart';
import '../DeliveryTimeSection/delivery_time_controller.dart';

class PaymentMethodController extends GetxController {
  var selectedIndex = 0.obs; // Selected payment method index
  var selectedPaymentMethod = 'Cash'.obs; // Store selected payment method
  var selectedAmount = ''.obs; // Store selected amount
  final DeliveryTimeController deliveryTimeController =
      DeliveryTimeController();
  final CartController cartController = CartController();
  final box = GetStorage();
  var cashCheckedList = [false, false, false, false].obs;
  var cardCheckedList = [false, false, false].obs;
  var showPaymentSection = false.obs;
  final DeliveryTimeController controller = DeliveryTimeController();

  var paybycashItems =
      <String>['No Change Needed', 'AED 50', 'AED 100', 'AED 200'].obs;
  var cardItems = <String>['AED 60', 'AED 200', 'AED 300'].obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    print(selectedIndex);
    if (selectedIndex.value == 0) {
      selectedPaymentMethod.value = 'Cash'; // Payment method
    } else {
      selectedPaymentMethod.value = 'Card'; // Payment method
    }
    print(selectedPaymentMethod);
  }

  void toggleCheckbox(int index) {
    if (selectedIndex.value == 0) {
      // Cash selected
      cardCheckedList.fillRange(0, cardCheckedList.length, false);
      cashCheckedList.fillRange(0, cashCheckedList.length, false);
      if (index < cashCheckedList.length) {
        cashCheckedList[index] = true;

        // Check if the selected item is "No Change Needed"
        if (paybycashItems[index] == 'No Change Needed') {
          selectedAmount.value = ''; // Set to null or empty string
        } else {
          selectedAmount.value =
              paybycashItems[index]; // Store the selected cash amount
        }
      }
    } else {
      // Card selected
      cashCheckedList.fillRange(0, cashCheckedList.length, false);
      cardCheckedList.fillRange(0, cardCheckedList.length, false);
      if (index < cardCheckedList.length) {
        cardCheckedList[index] = true;
        selectedAmount.value =
            cardItems[index]; // Store the selected card amount
      }
    }

    double amountAsDouble = convertToDouble(selectedAmount.value);
    print('Selected Amount as Double: $amountAsDouble');

    // Refresh the UI
    update();
  }

  double convertToDouble(String amount) {
    final numericString = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(numericString) ?? 0.0;
  }

  void backToDeliveryTime() {
    showPaymentSection.value = false;
  }

  void saveSelectedPaymentMethod() {
    if (selectedIndex.value == 0) {
      selectedPaymentMethod.value = 'Cash';
    } else {
      selectedPaymentMethod.value = 'Card';
    }

    print('Selected Payment Method: ${selectedPaymentMethod.value}');
    print('Selected Amount: ${selectedAmount.value}');
  }

  Future<void> postOrder() async {
    GetStorage bix = GetStorage();
    final DeliveryTimeController controller =
        Get.find<DeliveryTimeController>();
    final CollectionTimeController collectionTimecontroller =
    Get.find<CollectionTimeController>();
    final CartController cartcontroller = Get.find<CartController>();
    final BottomNavController bottomNavController =
        Get.find<BottomNavController>();
    final String token = box.read('access_token');

    print(
        'Selected Day : ${controller.selectedIndex.value == 0 ? controller.today : controller.tomorrow}');
    print('Selected Time Slot: ${controller.selectedTimeSlot.value}');
    print('count: ${cartcontroller.total_quantity}');

    print('method: $selectedPaymentMethod');

    double changeAmount = convertToDouble(selectedAmount.value);
    double totalAmount = convertToDouble(cartcontroller.total_amount.value);
    print('Change needed: $changeAmount');
    print('amount: $totalAmount');

    if (changeAmount == null) {
      changeAmount = 0.0;
      print('Change amount is null, setting to $changeAmount');
    }

    List<Map<String, dynamic>> items =
        cartcontroller.getCartItems().map((item) {
      return {
        "product_id": item['product_id'],
        "quantity": item['quantity'],
        "services": (item['services'] as List<dynamic>?)?.map((serviceItem) {
              // Ensure the serviceItem is mapped to the desired structure if needed
              return serviceItem
                  .toString(); // Adjust this as per the required format
            }).toList() ??
            [],
      };
    }).toList();
    print('Items: $items');
print(bix.read('selectedButton'));
    final Map<String, dynamic> body = {
      "type": bix.read('selectedButton'),
      "shop_id": 1,
      "collection" : {
        "date" : collectionTimecontroller.selectedIndex.value ==0
      ? controller.today
          : controller.tomorrow,
        "time_slot" : collectionTimecontroller.collectionTimeSlot.value
      },
      "delivery": {
        "date": controller.selectedIndex.value == 0
            ? controller.today
            : controller.tomorrow,
        "time_slot": controller.selectedTimeSlot.value,
      },
      "payment": {
        "method": selectedPaymentMethod.value.toLowerCase(),
        "change": changeAmount == 0 ? null : changeAmount
      },
      "total": {
        "count": cartcontroller.total_quantity.value,
        "amount": totalAmount,
      },
      "items": items
    };

    try {
      final response = await http.post(
        Uri.parse(Api.Order),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );

      // Check the response
      if (response.statusCode == 200) {
        print('Order placed successfully: ${response.body}');
        cartController.clearLocalCart();
        GetStorage().remove('status');
        Get.offAll(() => CustomBottomNavBar());
        Get.snackbar(
          'Order Success',
          'Your order has been placed successfully!',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 1),
        );
      } else {
        print(
            'Failed to place order: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
