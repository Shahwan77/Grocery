import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'api.dart';

class BottomApiService {

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(Api.Product));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
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
