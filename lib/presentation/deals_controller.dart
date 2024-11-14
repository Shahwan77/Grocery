import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import '../data/models/deals_model.dart';

class DealController extends GetxController {

  var isLoading = true.obs;
  var deals = <Deal>[].obs;

  @override
  void onInit() {
    fetchDeals();
    super.onInit();
  }

  Future<void> fetchDeals() async {
    final String? token = GetStorage().read('access_token');
    final String type = GetStorage().read('selectedButton') ?? 'grocery';
    final String? selectedShopId = GetStorage().read('selected_shop_id');
    final url = Uri.parse('${Api.ApiUrl}/deals?shop_id=$selectedShopId&type=grocery');

    try {
      isLoading(true);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          deals.value = (data['data'] as List)
              .map((deal) => Deal.fromJson(deal))
              .toList();
        }
      } else {
        print("Failed to load deals: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching deals: $e");
    } finally {
      isLoading(false);
    }
  }
}
