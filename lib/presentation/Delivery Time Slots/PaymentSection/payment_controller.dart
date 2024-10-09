import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Cart/cart_controller.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/order_model.dart';
import '../../bottomnav/controller/bottomnav_controller.dart';
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
          selectedAmount.value = paybycashItems[index]; // Store the selected cash amount
        }
      }
    } else {
      // Card selected
      cashCheckedList.fillRange(0, cashCheckedList.length, false);
      cardCheckedList.fillRange(0, cardCheckedList.length, false);
      if (index < cardCheckedList.length) {
        cardCheckedList[index] = true;
        selectedAmount.value = cardItems[index]; // Store the selected card amount
      }
    }

    double amountAsDouble = convertToDouble(selectedAmount.value);
    print('Selected Amount as Double: $amountAsDouble');

    // Refresh the UI
    update();
  }


  double convertToDouble(String amount) {
    // Extract the numeric part of the string
    final numericString = amount.replaceAll(
        RegExp(r'[^0-9.]'), ''); // Remove non-numeric characters
    return double.tryParse(numericString) ??
        0.0; // Convert to double, default to 0.0 if parsing fails
  }

  void backToDeliveryTime() {
    showPaymentSection.value = false;
  }

  void saveSelectedPaymentMethod() {
    // Store the selected payment method based on the selected index
    if (selectedIndex.value == 0) {
      selectedPaymentMethod.value = 'Cash'; // Payment method
    } else {
      selectedPaymentMethod.value = 'Card'; // Payment method
    }

    print('Selected Payment Method: ${selectedPaymentMethod.value}');
    print('Selected Amount: ${selectedAmount.value}');
  }

  Future<void> postOrder() async {
    final DeliveryTimeController controller = Get.find<DeliveryTimeController>();
    final CartController cartcontroller = Get.find<CartController>();
    final String token = box.read('access_token');

    print('Selected Day : ${controller.selectedIndex.value == 0 ? controller.today : controller.tomorrow}');
    print('Selected Time Slot: ${controller.selectedTimeSlot.value}');
    print('count: ${cartcontroller.total_quantity}');

    print('method: $selectedPaymentMethod');


    // Convert selected amount to double
    double changeAmount = convertToDouble(selectedAmount.value);
    double totalAmount = convertToDouble(cartcontroller.total_amount.value);
    print('Change needed: $changeAmount');
    print('amount: $totalAmount');


    // If changeAmount is null, set it to 0 or any default value
    if (changeAmount == null) {
      changeAmount = 0.0; // Set default value
      print('Change amount is null, setting to $changeAmount');
    }

    // Build items list dynamically from cart
    List<Map<String, dynamic>> items = cartcontroller.getCartItems().map((item) {
      return {
        "product_id": item['product_id'],
        "quantity": item['quantity'],
      };
    }).toList();
    print('Items: $items');

    final Map<String, dynamic> body = {
      "delivery": {
        "date": controller.selectedIndex.value == 0 ? controller.today : controller.tomorrow, // Based on selected index
        "time_slot": controller.selectedTimeSlot.value, // Use the selected time slot
      },
      "payment": {
        "method": selectedPaymentMethod.value.toLowerCase(), // or "card"
        "change": changeAmount == 0 ? null : changeAmount  // This will now always be a double
      },
      "total": {
        "count": cartcontroller.total_quantity.value, // item count
        "amount": totalAmount, // Adjust this as needed
      },
      "items": items // Add the dynamically generated items list
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse("https://grocery-dev.greendomains.in/api/order"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token' // Add the token to the header
        },
        body: json.encode(body),
      );

      // Check the response
      if (response.statusCode == 200) {
        print('Order placed successfully: ${response.body}');
        // cartController.clearLocalCart();
        Get.offAll(() => CustomBottomNavBar());
        Get.snackbar(
          'Order Success', // Title of the Snackbar
          'Your order has been placed successfully!', // Message of the Snackbar
          snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
          duration: Duration(seconds: 1), // Duration to show the Snackbar
        );
      } else {
        print('Failed to place order: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}
