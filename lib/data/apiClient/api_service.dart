import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../data/models/category_model.dart';
import '../../../data/apiClient/api.dart';
import '../models/models.dart';

class ApiService {
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
    final response = await http.get(Uri.parse(Api.PopularProduct));

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

  Future<List<Models>> fetchRiceCakes(int subcategoryId) async {
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
    final response = await http.get(Uri.parse(Api.DiscountProduct));

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

}
