import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/category_model.dart';
import '../../../data/apiClient/api.dart';
import '../models/models.dart';

class ApiService {
  final box = GetStorage();
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(Api.Category));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Models>> fetchPopularProducts() async {
    final token = box.read('access_token');
    final String apiUrl = token != null
        ? 'https://grocery-dev.greendomains.in/api/products/popular/cart'
        : Api.PopularProduct;

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: token != null ? {'Authorization': 'Bearer $token'} : null, // Add token to headers if it exists
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((item) => Models.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load popular products');
      }
    } else {
      throw Exception('Failed to fetch popular products');
    }
  }

  Future<List<Models>> fetchCategoryProducts(int categoryId) async {
    final response = await http.get(Uri.parse('${Api.CategoryProduct}=$categoryId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['data'] != null && data['data'] is List) {
        return (data['data'] as List)
            .map((item) => Models.fromJson(item))
            .toList();
      } else {
        throw Exception('Error: data is null or not a List');
      }
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<List<Models>> fetchTabs(int subcategoryId) async {
    final response = await http.get(Uri.parse('${Api.BaseUrl}/api/products?subcategory_id=$subcategoryId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'] is List) {
        List<dynamic> productsJson = data['data'];
        return productsJson.map((json) => Models.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch rice cakes');
    }
  }
  Future<List<Models>> fetchSubcategories(int categoryId) async {
    final response = await http.get(Uri.parse('${Api.BaseUrl}/api/product-subcategories?category_id=$categoryId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> subcategoriesJson = data['data'];
      return subcategoriesJson.map((json) => Models.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
  Future<List<Models>> fetchDiscountProducts() async {
    final token = box.read('access_token');
    // Determine the API endpoint based on the token's presence
    final String apiUrl = token != null
        ? 'https://grocery-dev.greendomains.in/api/products/discount/cart'
        : Api.DiscountProduct;

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: token != null ? {'Authorization': 'Bearer $token'} : null, // Add token to headers if it exists
    );

    if (response.statusCode == 200) {
      print('Token: $token');
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((item) => Models.fromJson(item)) // Make sure to use the correct model
            .toList();
      } else {
        throw Exception('Failed to load popular products');
      }
    } else {
      throw Exception('Failed to fetch popular products');
    }
  }
  Future<List<Models>> fetchPopularCategories() async {
    final response = await http.get(Uri.parse(Api.PopularCategories));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((item) => Models.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load popular products');
      }
    } else {
      throw Exception('Failed to fetch popular products');
    }
  }



  Future<List<Category>> fetchLaundryCategories() async {
    final response = await http.get(Uri.parse(Api.CategoryLaundry));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }


}
