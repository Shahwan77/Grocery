import 'package:get/get.dart';

class FavoriteController extends GetxController {
  // List to hold favorite items with name, price, and image
  var favoriteItems = <Map<String, String>>[].obs;

  // Toggle favorite status
  void toggleFavorite(String itemName, String itemPrice, String itemImage) {
    final itemIndex = favoriteItems.indexWhere((item) => item['name'] == itemName);
    if (itemIndex >= 0) {
      favoriteItems.removeAt(itemIndex);
    } else {
      favoriteItems.add({'name': itemName, 'price': itemPrice, 'image': itemImage});
    }
  }

  // Check if an item is in the favorites list
  bool isFavorite(String itemName) {
    return favoriteItems.any((item) => item['name'] == itemName);
  }
}
