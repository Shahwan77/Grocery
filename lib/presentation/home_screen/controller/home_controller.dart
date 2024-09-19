import 'package:get/get.dart';
import 'package:grocery/data/models/models.dart';
import '../../../data/apiClient/api_service.dart';
import '../../../data/models/category_model.dart';


class HomeController extends GetxController {
  var categories = <Category>[].obs;
  var productItems = <Models>[].obs;
  var isLoading = true.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchCategories();
    fetchPopularProducts();
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
      isLoading.value = true;
      final popularProducts = await _apiService.fetchPopularProducts();
      productItems.value = popularProducts;
    } catch (e) {
      print("Error fetching popular products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
