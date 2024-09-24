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
//   }
//
//   // Clear cart items both locally and from storage
//   void clearLocalCart() {
//     cartItems.clear(); // Clear the local cart items
//     box.remove('cartItems'); // Remove the stored cart items from GetStorage
//     printStoredItems(); // Optionally print the state
//   }
//
//   // Load cart items from local storage (GetStorage)
//   void loadCartItems() {
//     final savedCart = box.read('cartItems');
//     if (savedCart != null) {
//       cartItems.assignAll(List<Map<String, dynamic>>.from(savedCart));
//     }
//   }
//
//   // Save cart items to local storage (GetStorage)
//   void saveCartItems() {
//     box.write('cartItems', cartItems);
//     printStoredItems(); // Optionally print the stored items
//   }
//
//   // Get the count of unique items in the cart
//   int get uniqueItemCount => cartItems.length;
//
//   // Get the total quantity of items in the cart
//   int get itemCount =>
//       cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
//
//   // Fetch product data from the API
//   Future<void> loadProducts() async {
//     final fetchedProducts = await apiService.fetchProducts();
//     products.assignAll(fetchedProducts);
//   }
//
//
//   void toggleCart(int productId, String itemName, String itemPrice, String itemImage) {
//     final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
//
//     if (itemIndex >= 0) {
//       cartItems.removeAt(itemIndex);
//     } else {
//       cartItems.add({
//         'product_id': productId,
//         'name': itemName,
//         'price': itemPrice,
//         'image': itemImage,
//         'quantity': 1,
//       });
//     }
//
//
//     final token = box.read('access_token');
//     if (token != null) {
//
//       postCartItems(token);
//     } else {
//       saveCartItems();
//     }
//   }
//
//
//   // Update item quantity in the cart
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
//   bool isInCart(int productId) {
//     return cartItems.any((item) => item['product_id'] == productId);
//   }
//
//   List<Map<String, dynamic>> getCartItems() {
//     if (GetStorage().read('access_token') == null) {
//       return cartItems;
//     } else {
//       return fetchedcartItems;
//     }
//   }
//
//
//   void posticonCartItems(int productId, String itemName, String itemPrice, String itemImage) {
//     final token = box.read('access_token');
//
//     if (token == null) {
//       toggleCart(productId, itemName, itemPrice, itemImage);
//     } else {
//       postCartItems(token);
//     }
//   }
//
//   void removeFromCart(String itemName, String itemPrice, String itemImage) {
//     final itemIndex = cartItems.indexWhere((item) => item['name'] == itemName);
//     if (itemIndex >= 0) {
//       cartItems.removeAt(itemIndex);
//       saveCartItems();
//     }
//   }
//
//   void printStoredItems() {
//     final storedItems = box.read('cartItems');
//     if (storedItems != null && storedItems.isNotEmpty) {
//       print('Stored Cart Items: $storedItems');
//     } else {
//       print('No items found in local storage.');
//     }
//   }
//
//   Future<void> postCartItems(String token) async {
//     try {
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
//           //clearLocalCart();
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
//         if (data['items'] != null) {
//           fetchedcartItems
//               .assignAll(List<Map<String, dynamic>>.from(data['items']));
//           total.value = data['total'];
//           print('Fetched Cart Items: ${cartItems.toList()}');
//           print('Total Amount: ${total.value}');
//         }
//       } else {
//         Get.snackbar(
//             'Error', 'Failed to fetch cart items: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred while fetching cart items: $e');
//     }
//   }
//
//   int get localCartItemCount => cartItems.length;
//
//   int get serverCartItemCount => fetchedcartItems.length;
//
//   int get localItemCount => cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
//
//   int get serverItemCount => fetchedcartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
//
//   bool isLoggedIn() {
//     final accessToken = box.read('access_token');
//     return accessToken != null && accessToken.isNotEmpty;
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../Cart/cart_controller.dart';
// import '../../Cart/cart_page.dart';
// import '../../Promotions/promotions_page.dart';
// import '../../Search/search_page.dart';
// import '../../home_screen/page/home_page.dart';
// import '../controller/bottomnav_controller.dart';
//
// class CustomBottomNavBar extends StatelessWidget {
//   final List<Widget> pages = [
//     HomePage(),
//     SearchPage(),
//     PromotionsPage(),
//     CartPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final BottomNavController bottomNavController = Get.put(BottomNavController());
//     final CartController cartController = Get.put(CartController());
//
//     return Scaffold(
//       body: Obx(
//             () => pages[bottomNavController.selectedIndex.value],
//       ),
//       bottomNavigationBar: Obx(
//             () {
//           // Cart item count depends on whether the user is logged in or not
//           final cartItemCount = cartController.isLoggedIn()
//               ? cartController.serverCartItemCount
//               : cartController.localCartItemCount;
//
//           return BottomNavigationBar(
//             currentIndex: bottomNavController.selectedIndex.value,
//             onTap: (index) {
//               bottomNavController.updateIndex(index);
//             },
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: _buildIcon('assets/home.svg', 0, bottomNavController),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: _buildIcon('assets/search.svg', 1, bottomNavController),
//                 label: 'Search',
//               ),
//               BottomNavigationBarItem(
//                 icon: _buildIcon('assets/offer.svg', 2, bottomNavController),
//                 label: 'Promotions',
//               ),
//               BottomNavigationBarItem(
//                 icon: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     _buildIcon('assets/cart.svg', 3, bottomNavController),
//                     if (cartItemCount > 0)
//                       Positioned(
//                         right: -4,
//                         top: -4,
//                         child: Container(
//                           padding: EdgeInsets.all(6),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.green.shade800,
//                           ),
//                           constraints: BoxConstraints(
//                             minWidth: 18.w,
//                             minHeight: 18.h,
//                           ),
//                           child: Center(
//                             child: Text(
//                               '$cartItemCount',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 10.h,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 label: 'Cart',
//               ),
//             ],
//             selectedItemColor: Colors.green.shade800,
//             unselectedItemColor: Colors.green.shade800,
//             showUnselectedLabels: true,
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.white,
//           );
//         },
//       ),
//     );
//
//   }
//
//   Widget _buildIcon(String imagePath, int index, BottomNavController controller) {
//     bool isSelected = controller.selectedIndex.value == index;
//     return Container(
//       height: 36.h,
//       width: 40.w,
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.green.shade800 : Colors.transparent,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: SvgPicture.asset(
//         imagePath,
//         width: 22.w,
//         height: 22.h,
//         color: isSelected ? Colors.white : Colors.green.shade800,
//       ),
//     );
//   }
// }
// void toggleCart(int productId, String itemName, String itemPrice, String itemImage) {
//   final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
//
//   if (itemIndex >= 0) {
//     cartItems.removeAt(itemIndex);
//   } else {
//     // Add item to the cart
//     cartItems.add({
//       'product_id': productId,
//       'name': itemName,
//       'price': itemPrice,
//       'image': itemImage,
//       'quantity': 1,
//     });
//   }
//
//
//   final token = box.read('access_token');
//   if (token != null) {
//
//     postCartItems(token);
//   } else {
//     saveCartItems();
//   }
// }