import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  int get uniqueItemCount => cartItems.length;


  int get itemCount => cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  void toggleCart(String itemName, String itemPrice, String itemImage) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      cartItems.removeAt(itemIndex);
    } else {
      cartItems.add({
        'name': itemName,
        'price': itemPrice,
        'image': itemImage,
        'quantity': 1,
      });
    }
  }

  void updateQuantity(String itemName, int change) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      cartItems[itemIndex]['quantity'] += change;

      if (cartItems[itemIndex]['quantity'] <= 0) {
        cartItems.removeAt(itemIndex);
      } else {
        // Trigger an update to ensure the UI is refreshed
        cartItems.refresh();
      }
    }
  }

  bool isInCart(String itemName) {
    return cartItems.any((item) => item['name'] == itemName);
  }

  List<Map<String, dynamic>> getCartItems() {
    return cartItems;
  }

  void removeFromCart(String itemName, String itemPrice, String itemImage) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      cartItems.removeAt(itemIndex);
    }
  }

}