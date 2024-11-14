import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/apiClient/api.dart';
import '../../data/apiClient/bottom_api_services.dart';
import '../../data/models/models.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var popularProducts = <Models>[].obs;
  var fetchedcartItems = <Map<String, dynamic>>[].obs;
  var products = <Map<String, dynamic>>[].obs;
  final BottomApiService apiService = BottomApiService();
  var total_amount = "0.00".obs;
  var total_quantity = "0".obs;
  final box = GetStorage();
  GetStorage Box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadCartItems();
    if (isLoggedIn()) {
      final token = box.read('access_token');
      if (token != null) {
        fetchCartItems(token, 'grocery');
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
      fetchCartItems(token, 'grocery');
    }
  }

  Future<void> toggleCart(
      int productId,
      String itemName,
      String itemPrice,
      String itemImage,
      Map<int, Map<String, dynamic>>? selectedServices
      ) async {


    final isLaundry = Box.read('selectedButton') == 'laundry';

    if (!isLaundry) {
      final isAlreadyInFetchedCart = fetchedcartItems.any((item) => item['product_id'] == productId);
      if (isAlreadyInFetchedCart) {
        Get.snackbar('Info', '$itemName is already in the cart.');
        return;
      }

      final itemIndex = cartItems.indexWhere((item) => item['product_id'] == productId);
      if (itemIndex >= 0) {
        cartItems.removeAt(itemIndex);
      }
    }
    List<Map<String, dynamic>> servicesList = [];
    if (selectedServices != null) {
      selectedServices.forEach((id, service) {
        servicesList.add({
          'id': id,
          'name': service['name'],
          'price': service['price'],
        });
      });
    }
    print('fffff: ${servicesList}');
    // Create a new cart item
    final newItem = {
      'product_id': productId,
      'name': itemName,
      'price': itemPrice,
      'image': itemImage,
      'quantity': 1,
      'service': servicesList
    };

    cartItems.add(newItem);

    final token = box.read('access_token');
    if (token != null) {
      postCartItems(token, newItem, isLaundry ? 'laundry' : 'grocery').then((success) {
        if (success) {
          fetchedcartItems.add(newItem);
        } else {
          //Get.snackbar('Error', 'Failed to update cart.');
        }
      });
    } else {
      saveCartItems();
    }
  }

  void updateQuantity(int productId, int change) {
    if (isLoggedIn()) {
      final itemIndex = fetchedcartItems
          .indexWhere((item) => item['product_id'] == productId);
      if (itemIndex >= 0) {
        fetchedcartItems[itemIndex]['quantity'] = change;

        // Remove the item if quantity becomes zero or less
        // if (fetchedcartItems[itemIndex]['quantity'] <= 0) {
        //   fetchedcartItems.removeAt(itemIndex);
        // } else {
        //   fetchedcartItems.refresh();
        // }
        saveCartItems();
        final token = box.read('access_token');
        if (token != null) {
          postCartItems(token, fetchedcartItems[itemIndex], 'grocery');
        }
      }
    } else {
      final itemIndex =
      cartItems.indexWhere((item) => item['product_id'] == productId);
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

  // Future<void> placeOrder() async {
  //   // Logic to place the order...
  //   // Assume order is placed successfully
  //
  //   // After successful order placement
  //   clearLocalCart(); // Clear the cart
  //   // Show success message or navigate to a different page if needed
  //   Get.snackbar("Success", "Your order has been placed!");
  // }

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

  Future<void> removeItemFromCart(int productId) async {
    final token = box.read('access_token');
    if (token != null) {
      try {
        final response = await http.post(
          Uri.parse(Api.CartRemove),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "product_id": productId,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success']) {
            print(data['message']);
            removeItemLocally(productId);
            int currentQuantity = int.tryParse(total_quantity.value) ?? 0;
            if (currentQuantity > 0) {
              total_quantity.value = (currentQuantity - 1).toString();
            }
          } else {
            print("Failed to remove item from cart: ${data['message']}");
          }
        } else {
          print("Failed to remove item. Status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error removing item: $e");
      }
      // removeItemLocally(productId);
    }
  }

  void removeItemLocally(int productId) {
    final itemIndex =
    fetchedcartItems.indexWhere((item) => item['product_id'] == productId);
    if (itemIndex >= 0) {
      print("Deleted item from local cart: ${fetchedcartItems[itemIndex]}");
      fetchedcartItems.removeAt(itemIndex);
      fetchedcartItems.refresh();
    }

    final localItemIndex =
    cartItems.indexWhere((item) => item['product_id'] == productId);
    if (localItemIndex >= 0) {
      print("Deleted item from fetched cart: ${cartItems[itemIndex]}");
      cartItems.removeAt(localItemIndex);
      //saveCartItems();
    }
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
    } else {
      print('No items found in local storage.');
    }
  }

  Future<bool> postCartItems(
      String token, Map<String, dynamic> cartItem, String type) async {
    final String Type = box.read('selectedButton') ?? 'grocery';
    final String? selectedShopId = GetStorage().read('selected_shop_id');

    if (selectedShopId == null) {
      print("Error: 'shop_id' is missing.");
      return false;
    }

    final body = {
      'type': Type,
      'shop_id': selectedShopId,
      'items': [
        {
          'product_id': cartItem['product_id'],
          'quantity': cartItem['quantity'],
          'services': cartItem['service'],
        }
      ]
    };

    print("Request Body: $body");

    try {
      final response = await http.post(
        Uri.parse(Api.CartPost),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          await fetchCartItems(token, Type);
          return true;
        } else {
          print("Failed to add items to cart: ${data['message']}");
          return false;
        }
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }


  Future<void> fetchCartItems(String token, String type) async {
    GetStorage Box = GetStorage();
    final String? selectedShopId = GetStorage().read('selected_shop_id');
    String Type = Box.read('selectedButton')??'grocery';
    String baseUri = Type == 'grocery'
        ? Api.CartGetgrocery
        : Type == 'laundry'
        ? Api.CartGetlaundry
        : Api.CartGetgrocery;
    final uri = Uri.parse(baseUri).replace(queryParameters: {
      'shop_id': selectedShopId,
      'type': Type,
    });

    print("Selected API endpoint with query parameters: $uri");
    print("Authorization Token: $token");

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true && data['data'] != null) {
          final items = data['data']['items'];
          if (items != null) {
            fetchedcartItems.assignAll(List<Map<String, dynamic>>.from(items));
            total_amount.value = data['data']['total_amount'];
            total_quantity.value = data['data']['total_quantity'].toString();
            print('Fetched Cart Items: ${fetchedcartItems.toList()}');
            print('Total Amount: ${total_amount.value}');
          }
        }
      } else {
        // Get.snackbar(
        //     'Error', 'Failed to fetch cart items: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred while fetching cart items: $e');
    }
    print(Box.read('selectedButton'));
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