// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../../data/apiClient/api.dart';
// import '../../data/apiClient/bottom_api_services.dart';
//
// class CartController extends GetxController {
//   var cartItems = <Map<String, dynamic>>[].obs;
//   var fetchedcartItems = <Map<String, dynamic>>[].obs;
//   var products = <Map<String, dynamic>>[].obs;
//   final BottomApiService apiService = BottomApiService();
//   var total = "0.00".obs;
//   final box = GetStorage();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadCartItems();
//     if (isLoggedIn()) {
//       final token = box.read('access_token');
//       if (token != null) {
//         fetchCartItems(token); // Fetch existing cart items from server
//       }
//     }
//   }
//
//   // Fetch existing cart items from local storage
//   void loadCartItems() {
//     final savedCart = box.read('cartItems');
//     if (savedCart != null) {
//       cartItems.assignAll(List<Map<String, dynamic>>.from(savedCart));
//     }
//   }
//
//   // Post each cart item that is not already on the server
//   Future<void> postLoginCartItems() async {
//     final token = box.read('access_token');
//     if (token != null) {
//       for (var localItem in cartItems) {
//         // Check if the item is not already fetched from the server
//         final isAlreadyPosted = fetchedcartItems.any(
//               (item) => item['product_id'] == localItem['product_id'],
//         );
//         if (!isAlreadyPosted) {
//           await postSingleCartItem(localItem, token);
//         }
//       }
//     }
//   }
//
//   // Post a single cart item to the server
//   Future<void> postSingleCartItem(Map<String, dynamic> item, String token) async {
//     try {
//       final response = await http.post(
//         Uri.parse(Api.CartPost),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({
//           'product_id': item['product_id'],
//           'quantity': item['quantity'],
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success']) {
//           Get.snackbar('Success', '${item['name']} added to the server cart.');
//           await fetchCartItems(token); // Optionally fetch updated cart items from server after posting
//         } else {
//           Get.snackbar('Error', 'Failed to add ${item['name']} to cart.');
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to post cart item: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while posting cart items: $e');
//     }
//   }
//
//   // Method to toggle cart item (add/remove)
//   void toggleCart(int productId, String itemName, String itemPrice, String itemImage) {
//     final isAlreadyInServerCart = fetchedcartItems.any((item) => item['product_id'] == productId);
//
//     if (isAlreadyInServerCart) {
//       Get.snackbar('Info', '$itemName is already in the cart.');
//       return;
//     }
//
//     final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
//
//     if (itemIndex >= 0) {
//       cartItems.removeAt(itemIndex);
//     } else {
//       final newItem = {
//         'product_id': productId,
//         'name': itemName,
//         'price': itemPrice,
//         'image': itemImage,
//         'quantity': 1,
//       };
//       cartItems.add(newItem);
//
//       final token = box.read('access_token');
//       if (token != null) {
//         // Post only the newly added item
//         postCartItems(token);      } else {
//         saveCartItems(); // Save locally if not logged in
//       }
//     }
//   }
//
//   // Update the quantity of items in the cart
//   void updateQuantity(String itemName, int change) {
//     final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
//     if (itemIndex >= 0) {
//       cartItems[itemIndex]['quantity'] += change;
//
//       if (cartItems[itemIndex]['quantity'] <= 0) {
//         cartItems.removeAt(itemIndex);
//       } else {
//         cartItems.refresh();
//       }
//       saveCartItems();
//     }
//   }
//
//   // Check if an item is in the cart
//   bool isInCart(int productId) {
//     return cartItems.any((item) => item['product_id'] == productId);
//   }
//
//   // Get cart items from local storage or server
//   List<Map<String, dynamic>> getCartItems() {
//     if (GetStorage().read('access_token') == null) {
//       return cartItems;
//     } else {
//       return fetchedcartItems;
//     }
//   }
//
//   // Save cart items locally
//   void saveCartItems() {
//     box.write('cartItems', cartItems);
//     printStoredItems();
//   }
//
//   // Print stored cart items for debugging
//   void printStoredItems() {
//     final storedItems = box.read('cartItems');
//     if (storedItems != null && storedItems.isNotEmpty) {
//       print('Stored Cart Items: $storedItems');
//     } else {
//       print('No items found in local storage.');
//     }
//   }
//
//   // Post cart items to server after login
//   void afterLogin() {
//     final token = box.read('access_token');
//     if (token != null) {
//       fetchCartItems(token);
//       postLoginCartItems(); // Post local cart items to server
//     }
//   }
//
//   // Remove item from cart
//   void removeFromCart(String itemName, String itemPrice, String itemImage) {
//     final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
//     if (itemIndex >= 0) {
//       cartItems.removeAt(itemIndex);
//       saveCartItems();
//     }
//   }
//
//   // Post all cart items to the server
//   Future<void> postCartItems(String token) async {
//     try {
//
//       for (var item in cartItems) {
//         await postSingleCartItem(item, token);
//       }
//
//       final formattedCartItems = cartItems.map((item) {
//         return {
//           'product_id': item['product_id'],
//           'quantity': item['quantity'],
//         };
//       }).toList();
//
//       final response = await http.post(
//         Uri.parse(Api.CartPost),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(formattedCartItems),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success']) {
//           Get.snackbar('Success', data['message']);
//           await fetchCartItems(token); // Fetch updated cart from server
//         } else {
//           Get.snackbar('Error', 'Failed to add items to cart');
//         }
//       } else {
//         Get.snackbar(
//             'Error', 'Failed to post cart items: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while posting cart items: $e');
//     }
//   }
//
//   // Fetch cart items from the server
//   Future<void> fetchCartItems(String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse(Api.CartGet),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         if (data['success'] == true && data['data'] != null) {
//           final items = data['data']['items'];
//           if (items != null) {
//             fetchedcartItems.assignAll(List<Map<String, dynamic>>.from(items));
//             total.value = data['data']['total'];
//             print('Fetched Cart Items: ${fetchedcartItems.toList()}');
//             print('Total Amount: ${total.value}');
//           }
//         }
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while fetching cart items: $e');
//     }
//   }
//   void clearLocalCart() {
//     cartItems.clear();
//     box.remove('cartItems');
//     printStoredItems();
//   }
//   // Check if the user is logged in
//   bool isLoggedIn() {
//     final accessToken = box.read('access_token');
//     return accessToken != null && accessToken.isNotEmpty;
//   }
//
//   int get localCartItemCount => cartItems.length;
//
//   int get serverCartItemCount => fetchedcartItems.length;
//
//   int get localItemCount =>
//       cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
//
//   int get serverItemCount =>
//       fetchedcartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
// }




// void updateQuantity(String itemName, int change) {
//   if (isLoggedIn()) {
//     final itemIndex = fetchedcartItems.indexWhere((item) => item['name'] == itemName);
//     if (itemIndex >= 0) {
//       fetchedcartItems[itemIndex]['quantity'] += change;
//
//       if (fetchedcartItems[itemIndex]['quantity'] <= 0) {
//         fetchedcartItems.removeAt(itemIndex);
//       } else {
//         fetchedcartItems.refresh();
//       }
//       saveCartItems();
//       final token = box.read('access_token');
//       if (token != null) {
//         saveCartItems(); // Post updated cart to server
//       }
//     }
//   } else {
//     final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
//     if (itemIndex >= 0) {
//       cartItems[itemIndex]['quantity'] += change;
//
//       if (cartItems[itemIndex]['quantity'] <= 0) {
//         cartItems.removeAt(itemIndex);
//       } else {
//         cartItems.refresh();
//       }
//       saveCartItems();
//     }
//   }
// }
