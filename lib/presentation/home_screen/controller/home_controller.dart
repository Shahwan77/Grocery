import 'package:get/get.dart';
import '../../../data/apiClient/api_service.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/models.dart';

class HomeController extends GetxController {
  var categories = <Category>[].obs;
  var popularProducts = <Models>[].obs;
  var discountProducts = <Models>[].obs;
  var popularCategories = <Models>[].obs;
  var isLoading = true.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchCategories();
    fetchPopularProducts();
    fetchDiscountProducts();
    fetchPopularCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      final categoryList = await _apiService.fetchCategories();
      categories.value = categoryList;
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPopularProducts() async {
    try {
      final popularProductsList = await _apiService.fetchPopularProducts();
      popularProducts.value = popularProductsList;
    } catch (e) {
      print("Error fetching popular products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDiscountProducts() async {
    try {
      final discountProductsList = await _apiService.fetchDiscountProducts();
      discountProducts.value = discountProductsList;
    } catch (e) {
      print("Error fetching discount products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPopularCategories() async {
    try {
      final popularCategoriesList = await _apiService.fetchPopularCategories();
      popularCategories.value = popularCategoriesList;
    } catch (e) {
      print("Error fetching popular categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    await fetchCategories();
    await fetchPopularProducts();
    await fetchDiscountProducts();
    await fetchPopularCategories();
    isLoading.value = false;
    await Future.delayed(Duration(seconds: 0));
  }
}