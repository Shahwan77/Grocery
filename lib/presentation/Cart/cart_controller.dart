import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/apiClient/api.dart';
import '../../data/apiClient/bottom_api_services.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var fetchedcartItems = <Map<String, dynamic>>[].obs;
  var products = <Map<String, dynamic>>[].obs;
  final BottomApiService apiService = BottomApiService();
  var total = "0.00".obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
    if (isLoggedIn()) {
      final token = box.read('access_token');
      if (token != null) {
        fetchCartItems(token);
      }
    }
  }

  void clearLocalCart() {
    cartItems.clear();
    box.remove('cartItems');
    printStoredItems();
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

  int get itemCount =>
      cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  Future<void> loadProducts() async {
    final fetchedProducts = await apiService.fetchProducts();
    products.assignAll(fetchedProducts);
  }

  void afterLogin() {
    final token = box.read('access_token');
    if (token != null) {
      fetchCartItems(token);
    }
  }

  void toggleCart(int productId, String itemName, String itemPrice, String itemImage) {
    final isAlreadyInFetchedCart = fetchedcartItems.any((item) => item['product_id'] == productId);

    if (isAlreadyInFetchedCart) {
      Get.snackbar('Info', '$itemName is already in the cart.');
      return;
    }

    final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);

    // Create a new cart item
    final newItem = {
      'product_id': productId,
      'name': itemName,
      'price': itemPrice,
      'image': itemImage,
      'quantity': 1,
    };

    // Add or remove the item from the local cart
    if (itemIndex >= 0) {
      cartItems.removeAt(itemIndex);
    } else {
      cartItems.add(newItem);
    }

    final token = box.read('access_token');
    if (token != null) {
      // Post only the newly added item to the server
      postCartItems(token, newItem).then((success) {
        if (success) {
          fetchedcartItems.add(newItem); // Add item to fetched cart after posting
        } else {
          Get.snackbar('Error', 'Failed to update cart.');
        }
      });
    } else {
      saveCartItems(); // Save locally if no token
    }
  }


  void updateQuantity(int productId, int change) {
    if (isLoggedIn()) {
      final itemIndex = fetchedcartItems.indexWhere((item) => item['product_id'] == productId);
      if (itemIndex >= 0) {
        fetchedcartItems[itemIndex]['quantity'] += change;

        // Remove the item if quantity becomes zero or less
        if (fetchedcartItems[itemIndex]['quantity'] <= 0) {
          fetchedcartItems.removeAt(itemIndex);
        } else {
          fetchedcartItems.refresh();
        }
        saveCartItems();
        final token = box.read('access_token');
        if (token != null) {
          saveCartItems();
        }
      }
    } else {
      final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
      if (itemIndex >= 0) {
        cartItems[itemIndex]['quantity'] += change;

        // Remove the item if quantity becomes zero or less
        if (cartItems[itemIndex]['quantity'] <= 0) {
          cartItems.removeAt(itemIndex);
        } else {
          cartItems.refresh();
        }
        saveCartItems();
      }
    }
  }




  bool isInCart(int productId) {
    return cartItems.any((item) => item['product_id'] == productId);
  }

  List<Map<String, dynamic>> getCartItems() {
    if (GetStorage().read('access_token') == null) {
      return cartItems;
    } else {
      return fetchedcartItems;
    }
  }

  // void posticonCartItems(
  //     int productId, String itemName, String itemPrice, String itemImage) {
  //   final token = box.read('access_token');
  //
  //   if (token == null) {
  //     toggleCart(productId, itemName, itemPrice, itemImage);
  //   } else {
  //     postCartItems(token);
  //   }
  // }

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
    } else {
      print('No items found in local storage.');
    }
  }

  Future<bool> postCartItems(String token, Map<String, dynamic> cartItem) async {
    try {
      // Send the POST request to the API with a single cart item
      final response = await http.post(
        Uri.parse(Api.CartPost),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode([{
          'product_id': cartItem['product_id'],
          'quantity': cartItem['quantity'],
        }]), // Post just the single cart item
      );

      // Handle the server response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success']) {
          Get.snackbar('Success', data['message']);
          // Optionally fetch the updated cart from server to sync local cart
          await fetchCartItems(token);
          return true;
        } else {
          Get.snackbar('Error', 'Failed to add items to cart');
          return false;
        }
      } else {
        Get.snackbar('Error', 'Failed to post cart item: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while posting cart item: $e');
      return false;
    }
  }



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

        if (data['success'] == true && data['data'] != null) {
          // Access the items from the response
          final items = data['data']['items'];
          if (items != null) {
            // Assign the fetched items to the observable list
            fetchedcartItems.assignAll(List<Map<String, dynamic>>.from(items));
            // Access the total from the response
            total.value = data['data']['total'];
            print('Fetched Cart Items: ${fetchedcartItems.toList()}');
            print('Total Amount: ${total.value}');
          }
        }
      } else {
        // Handle the error response
        // Get.snackbar('Error', 'Failed to fetch cart items: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle any exceptions
      // Get.snackbar('Error', 'An error occurred while fetching cart items: $e');
    }
  }

  int get localCartItemCount => cartItems.length;

  int get serverCartItemCount => fetchedcartItems.length;

  int get localItemCount =>
      cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  int get serverItemCount =>
      fetchedcartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  bool isLoggedIn() {
    final accessToken = box.read('access_token');
    return accessToken != null && accessToken.isNotEmpty;
  }
}
