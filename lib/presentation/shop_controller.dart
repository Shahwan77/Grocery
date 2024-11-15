import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/models/shop_model.dart';
import 'shop.dart'; // Import your Shop model

class StoreController extends GetxController {
  var shops = <String, Shop>{}.obs; // Use RxMap<String, Shop> instead of RxMap<String, String>
  var isLoading = true.obs;
  final box = GetStorage();

  // Make selectedStoreId an observable so it can be reacted upon in the UI
  var selectedStoreId = ''.obs;

  Future<void> fetchShops() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('${Api.ApiUrl}/shops'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          // Parse the shop data into Shop objects and store them in the RxMap
          shops.value = Map<String, Shop>.fromIterable(
            responseData['data'],
            key: (item) => item['id'].toString(),
            value: (item) => Shop.fromJson(item),
          );
        } else {
          print('Failed to load shops');
        }
      } else {
        print('Failed to fetch data from API');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectStore(String storeId) {
    selectedStoreId.value = storeId;  // Update the observable
    box.write('selected_shop_id', storeId); // Save the selected store ID to GetStorage
  }

  @override
  void onInit() {
    super.onInit();
    fetchShops();

    // Optionally, read the saved selected store ID when the controller is initialized
    String? savedStoreId = box.read('selected_shop_id');
    if (savedStoreId != null) {
      selectedStoreId.value = savedStoreId;
    }
  }
}
