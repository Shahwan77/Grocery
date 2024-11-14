// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import '../../data/models/promotion_model.dart';
//
// class PromotionController extends GetxController {
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   // Modify fetchPromotions to return Future<List<Promotion>>
//   Future<List<Promotion>> fetchPromotions() async {
//     final String type = GetStorage().read('selectedButton') ?? 'grocery';
//     final String? selectedShopId = GetStorage().read('selected_shop_id');
//     final String token = GetStorage().read('access_token');
//
//     try {
//       isLoading(true); // Set loading state to true
//       final response = await http.get(
//         Uri.parse("https://grocery-dev.greendomains.in/api/promotions?shop_id=$selectedShopId&type=$type"),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print(response.body);
//         if (data['success']) {
//           var promotionList = (data['data'] as List)
//               .map((promotionJson) => Promotion.fromJson(promotionJson))
//               .toList();
//           return promotionList;
//         } else {
//           errorMessage.value = 'Failed to load promotions.';
//           return [];
//         }
//       } else {
//         errorMessage.value = 'Error: ${response.statusCode}';
//         return [];
//       }
//     } catch (e) {
//       errorMessage.value = 'An error occurred: $e';
//       return [];
//     } finally {
//       isLoading(false); // Set loading state to false
//     }
//   }
// }
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/models/promotion_model.dart';

class PromotionsController extends GetxController {
  var isLoading = true.obs;
  var promotionsList = <Promotion>[].obs;

  Future<void> fetchPromotions() async {
    final String type = GetStorage().read('selectedButton') ?? 'grocery';
    final String? selectedShopId = GetStorage().read('selected_shop_id');
    final String token = GetStorage().read('access_token');
    try {
      isLoading(true);
      final url = Uri.parse('https://grocery-dev.greendomains.in/api/promotions?shop_id=1&type=grocery');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final promotionsData = (jsonResponse['data'] as List)
            .map((item) => Promotion.fromJson(item))
            .toList();
        promotionsList.assignAll(promotionsData);
      } else {
        print('Failed to load promotions: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching promotions: $e");
    } finally {
      isLoading(false);
    }
  }
}
