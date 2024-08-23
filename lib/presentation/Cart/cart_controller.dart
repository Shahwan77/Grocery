import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  int get itemCount => cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  void toggleCart(String itemName, String itemPrice, String itemImage) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      // Item already in the cart, remove it
      cartItems.removeAt(itemIndex);
    } else {
      // Item not in the cart, add it
      cartItems.add({
        'name': itemName,
        'price': itemPrice,
        'image': itemImage,
        'quantity': 1, // Initial quantity set to 1
      });
    }
  }

  void updateQuantity(String itemName, int change) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      // Update quantity
      cartItems[itemIndex]['quantity'] += change;

      // Remove item if quantity is zero or less
      if (cartItems[itemIndex]['quantity'] <= 0) {
        cartItems.removeAt(itemIndex);
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
