import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreController extends GetxController {
  var shops = <String, String>{}.obs; // Use RxMap<String, String> to store shops data
  var isLoading = true.obs;
  final box = GetStorage(); // GetStorage instance for storing selected shop ID

  Future<void> fetchShops() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('${Api.ApiUrl}/shops'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          // Parse data as Map<String, String> and assign to shops
          shops.value = Map<String, String>.from(responseData['data']);
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
    box.write('selected_shop_id', storeId);
  }

  @override
  void onInit() {
    super.onInit();
    fetchShops();
  }
}
