import 'package:get/get.dart';

import '../Cart/cart_controller.dart';

class DeliveryTimeSlotsController extends GetxController {
  final CartController cartController = Get.put(CartController());

  void saveSelectedDeliveryTimeSlots() {
    List<dynamic> cartItems = cartController.getCartItems();

    if (cartItems.isNotEmpty) {
      print('Order Details:');
      for (var item in cartItems) {
        print(item);
        print(cartController.total_amount);
        print(cartController.total_quantity);
      }
    } else {
      print('No items in the cart.');
    }
  }
}
