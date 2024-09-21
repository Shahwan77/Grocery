import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/apiClient/api.dart';
import '../../data/apiClient/bottom_api_services.dart';
import '../../tstts.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var products = <Map<String, dynamic>>[].obs; //
  final BottomApiService apiService = BottomApiService();

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCartItems();

  }

  void loadCartItems() {
    final savedCart = box.read('cartItems');
    if (savedCart != null) {
      cartItems.assignAll(List<Map<String, dynamic>>.from(savedCart));
    }
  }

  void saveCartItems() {
    box.write('cartItems', cartItems);
    printStoredItems();
  }

  int get uniqueItemCount => cartItems.length;

  int get itemCount => cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));


  Future<void> loadProducts() async {
    final fetchedProducts = await apiService.fetchProducts();
    products.assignAll(fetchedProducts);
  }

  void toggleCart(int productId, String itemName, String itemPrice, String itemImage) {
    final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
    if (itemIndex >= 0) {
      cartItems.removeAt(itemIndex);
    } else {
      cartItems.add({
        'product_id': productId,
        'name': itemName,
        'price': itemPrice,
        'image': itemImage,
        'quantity': 1,
      });
    }
    saveCartItems();
  }

  void updateQuantity(String itemName, int change) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      cartItems[itemIndex]['quantity'] += change;

      if (cartItems[itemIndex]['quantity'] <= 0) {
        cartItems.removeAt(itemIndex);
      } else {
        cartItems.refresh();
      }
      saveCartItems();
    }
  }

  bool isInCart(int productId) {
    return cartItems.any((item) => item['product_id'] == productId);
  }

  List<Map<String, dynamic>> getCartItems() {
    return cartItems;
  }

  void removeFromCart(String itemName, String itemPrice, String itemImage) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      cartItems.removeAt(itemIndex);
      saveCartItems();
    }
  }

  void printStoredItems() {
    final storedItems = box.read('cartItems');
    if (storedItems != null && storedItems.isNotEmpty) {
      print('Stored Cart Items: $storedItems');
     // print('Total number of items in cart: ${cartItems.length}');
    } else {
      print('No items found in local storage.');
    }
  }

  Future<void> postCartItems(String token) async {
    try {
      final response = await http.post(
        Uri.parse(Api.CartPost),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode({'items': cartItems}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          Get.snackbar('Success', data['message']);
        } else {
          Get.snackbar('Error', 'Failed to add items to cart');
        }
      } else {
        Get.snackbar('Error', 'Failed to post cart items: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while posting cart items: $e');
    }
  }

}
