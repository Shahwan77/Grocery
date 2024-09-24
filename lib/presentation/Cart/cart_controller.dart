import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/apiClient/api.dart';
import '../../data/apiClient/bottom_api_services.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var fetcedcartItems = <Map<String, dynamic>>[].obs;
  var products = <Map<String, dynamic>>[].obs;
  final BottomApiService apiService = BottomApiService();
  var total = "0.00".obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  // Clear cart items both locally and from storage
  void clearLocalCart() {
    cartItems.clear(); // Clear the local cart items
    box.remove('cartItems'); // Remove the stored cart items from GetStorage
    printStoredItems(); // Optionally print the state
  }

  // Load cart items from local storage (GetStorage)
  void loadCartItems() {
    final savedCart = box.read('cartItems');
    if (savedCart != null) {
      cartItems.assignAll(List<Map<String, dynamic>>.from(savedCart));
    }
  }

  // Save cart items to local storage (GetStorage)
  void saveCartItems() {
    box.write('cartItems', cartItems);
    printStoredItems(); // Optionally print the stored items
  }

  // Get the count of unique items in the cart
  int get uniqueItemCount => cartItems.length;

  // Get the total quantity of items in the cart
  int get itemCount =>
      cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  // Fetch product data from the API
  Future<void> loadProducts() async {
    final fetchedProducts = await apiService.fetchProducts();
    products.assignAll(fetchedProducts);
  }

  // Add or remove items from the cart
  void toggleCart(
      int productId, String itemName, String itemPrice, String itemImage) {
    final itemIndex =
        cartItems.indexWhere((item) => item['product_id'] == productId);
    if (itemIndex >= 0) {
      cartItems.removeAt(itemIndex); // Remove if already in cart
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

  // Update item quantity in the cart
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

  // Check if an item is already in the cart
  bool isInCart(int productId) {
    return cartItems.any((item) => item['product_id'] == productId);
  }

  // Get all cart items
  List<Map<String, dynamic>> getCartItems() {
    if (GetStorage().read('access_token') == null) {
      return cartItems;
    } else {
      return fetcedcartItems;
    }
  }


  void posticonCartItems(int productId, String itemName, String itemPrice, String itemImage) {
    final token = box.read('access_token');

    if (token == null) {
      // If the token is null, toggle the cart item
      toggleCart(productId, itemName, itemPrice, itemImage);
    } else {
      // If the token is not null, post the cart items to the server
      postCartItems(token);
    }
  }

  // Remove an item from the cart
  void removeFromCart(String itemName, String itemPrice, String itemImage) {
    final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      cartItems.removeAt(itemIndex);
      saveCartItems();
    }
  }

  // Print stored cart items (for debugging)
  void printStoredItems() {
    final storedItems = box.read('cartItems');
    if (storedItems != null && storedItems.isNotEmpty) {
      print('Stored Cart Items: $storedItems');
    } else {
      print('No items found in local storage.');
    }
  }

  // Post cart items to the server
  Future<void> postCartItems(String token) async {
    try {
      // Prepare the cart items for posting
      final formattedCartItems = cartItems.map((item) {
        return {
          'product_id': item['product_id'],
          'quantity': item['quantity'],
        };
      }).toList();

      final response = await http.post(
        Uri.parse(Api.CartPost),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(formattedCartItems),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          Get.snackbar('Success', data['message']);
          await fetchCartItems(token); // Fetch updated cart from server
          //clearLocalCart();
        } else {
          Get.snackbar('Error', 'Failed to add items to cart');
        }
      } else {
        Get.snackbar(
            'Error', 'Failed to post cart items: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while posting cart items: $e');
    }
  }

  // Fetch cart items from the server
  Future<void> fetchCartItems(String token) async {
    try {
      final response = await http.get(
        Uri.parse(Api.CartGet),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['items'] != null) {
          fetcedcartItems
              .assignAll(List<Map<String, dynamic>>.from(data['items']));
          total.value = data['total'];
          print('Fetched Cart Items: ${cartItems.toList()}');
          print('Total Amount: ${total.value}');
        }
      } else {
        Get.snackbar(
            'Error', 'Failed to fetch cart items: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching cart items: $e');
    }
  }

  // Check if the user is logged in
  bool isLoggedIn() {
    final accessToken = box.read('access_token');
    return accessToken != null && accessToken.isNotEmpty;
  }
}
