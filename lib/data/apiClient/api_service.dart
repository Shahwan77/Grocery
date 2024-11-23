import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/category_model.dart';
import '../../../data/apiClient/api.dart';
import '../models/models.dart';
import '../models/most_popular_model.dart';
import '../models/promotion_model.dart';

class ApiService {
  final box = GetStorage();
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(Api.Category));

    if (response.statusCode == 200) {
      print(response.request);
      final data = jsonDecode(response.body)['data'];
      if (data != null && data is List) {
        return data.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('No category data found');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }




  Future<List<Models>> fetchPopularProducts() async {
    final String? selectedStoreId = box.read('selected_shop_id');

    // Use the selected store ID to build the API URL
    final String apiUrl = '${Api.PopularProduct}';

    // Make the API request without checking the token
    final response = await http.get(Uri.parse(apiUrl));

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

  Future<List<Models>> fetchCategoryProducts(int categoryId, String type) async {
    final String? selectedStoreId = box.read('selected_shop_id');
    final response = await http.get(Uri.parse('${Api.CategoryProduct}=$categoryId&type=$type&shop_id=$selectedStoreId'));

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

  Future<List<Models>> fetchTabs(int subcategoryId, String type) async {
    final String? selectedStoreId = box.read('selected_shop_id');

    final response = await http.get(Uri.parse('${Api.BaseUrl}/api/products?subcategory_id=$subcategoryId&type=$type&shop_id=$selectedStoreId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'] is List) {
        List<dynamic> productsJson = data['data'];
        return productsJson.map((json) => Models.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch tabs');
    }
  }

  Future<List<Models>> fetchSubcategories(int categoryId, String type) async {
    final String? selectedStoreId = box.read('selected_shop_id');
    //final response = await http.get(Uri.parse('${Api.BaseUrl}/api/product-subcategories?category_id=$categoryId&type=$type'));
    final response = await http.get(Uri.parse('${Api.BaseUrl}/api/product-subcategories?category_id=$categoryId&type=$type&shop_id=$selectedStoreId'));


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> subcategoriesJson = data['data'];
      return subcategoriesJson.map((json) => Models.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
  Future<List<Models>> fetchDiscountProducts() async {
    // Directly use the Api.DiscountProduct URL without checking for token
    final String apiUrl = Api.DiscountProduct;

    // Make the API request without checking the token
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((item) => Models.fromJson(item)) // Use the correct model
            .toList();
      } else {
        throw Exception('Failed to load discount products');
      }
    } else {
      throw Exception('Failed to fetch discount products');
    }
  }

  Future<List<MostCategory>> fetchPopularCategories() async {
    final String? selectedStoreId = box.read('selected_shop_id');
    //final response = await http.get(Uri.parse(Api.PopularCategories));
    final response = await http.get(Uri.parse('${Api.PopularCategories}'));


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((item) => MostCategory.fromJson(item))
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
      print(response.request);
      final data = jsonDecode(response.body)['data'] as List;
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }



}