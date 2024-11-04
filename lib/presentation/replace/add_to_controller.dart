import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  final int? id;
  final int? itemId;
  ProductController(this.itemId, this.id);
  var quantity = 1.obs;
  var isDefaultReplacement = false.obs;
  double? itemPrice; // Store the item price

  void setItemPrice(double? price) {
    itemPrice = price;
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  void toggleDefaultReplacement() {
    isDefaultReplacement.value = !isDefaultReplacement.value;
  }

  double get totalPrice {
    return (itemPrice ?? 0) * quantity.value;
  }

  Future<void> postReplacementOrder() async {
    final url = 'https://grocery-dev.greendomains.in/api/orders/replace/confirm';
    final String? token = GetStorage().read('access_token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token
    };

    final body = jsonEncode({
      'item_id': id, // You should replace this with the actual item ID
      'replacement_items': [
        {
          'id': itemId, // Replace with the actual item ID if needed
          // 'name': itemName, // Replace with the actual item name if needed
          'quantity': quantity.value, // Use the current quantity
        },
      ],
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        print(itemId);
        print(id);
        // Handle success
        Get.snackbar("Success", "Order confirmed!");
      } else {
        // Handle error
        Get.snackbar("Error", "Failed to confirm order: ${response.body}");
      }
    } catch (e) {
      // Handle exception
      // Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
