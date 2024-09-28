import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'api.dart';

class BottomApiService {

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(Api.Product));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          // Return the list of products from the 'data2' field
          return List<Map<String, dynamic>>.from(responseData['data']);
        } else {
          print('API returned an error');
          return [];
        }
      } else {
        print('Failed to load products');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
