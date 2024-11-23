import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import '../../../data/apiClient/api_service.dart';
import '../../../data/models/aj_models.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/models.dart';
import '../../../data/models/most_popular_model.dart';
import '../../../data/models/promotion_model.dart';
import '../../Cart/cart_controller.dart';
import 'package:http/http.dart'as http;

class HomeController extends GetxController {
  var categories = <Category>[].obs;
  // var categories12 = <Category>[].obs;
  var popularProducts = <Models>[].obs;
  var discountProducts = <Models>[].obs;
  var popularCategories = <MostCategory>[].obs;
  var promotionsList = <Promotion>[].obs;
  var ajProducts = <AjProduct>[].obs;
  var isLoading = true.obs;
  var selectedIndex = 0.obs;
  var isLaundrySelected = false.obs;
  var isAjSelected = false.obs;
  var isOfferSelected = false.obs;
  var isGrocerySelected = false.obs;
  final ApiService _apiService = ApiService();
  final CartController cartController = Get.put(CartController());
  var promotions = <Promotion>[].obs;
  var errorMessage = ''.obs;


  @override
  void onInit() {
    super.onInit();

    final String? selectedButton = GetStorage().read('selectedButton');

    if (selectedButton == null) {
      fetchCategories();
      GetStorage().write('selectedButton', 'grocery');
      selectedIndex.value = 0;
    } else if (selectedButton == 'grocery') {
      fetchCategories();
      selectedIndex.value = 0;
    } else if (selectedButton == 'laundry') {
      fetchLaundry();
      selectedIndex.value = 1;
    } else if (selectedButton == 'promotion') {
      fetchPromotions();
      selectedIndex.value = 2;
    }
    else if (selectedButton == 'aj') {
      fetchAjProducts();
      selectedIndex.value = 3;
    }
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
    selectedIndex.value = 0;

    isLaundrySelected.value = false;
    isOfferSelected.value=false;
    isAjSelected.value = false;
    isGrocerySelected.value = true;
    //cartController.selectedType.value = 'grocery';
  }

  Future<void> fetchLaundry() async {
    try {
      final categoryList = await _apiService.fetchLaundryCategories();
      categories.value = categoryList;
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
    selectedIndex.value = 1;
    isLaundrySelected.value = true;
    isAjSelected.value = false;
    isOfferSelected.value=false;
    isGrocerySelected.value = false;
    //cartController.selectedType.value = 'laundry';
  }
  Future<void> fetchPromotions() async {
    final String type = GetStorage().read('selectedButton') ?? 'grocery';
    final String? selectedShopId = GetStorage().read('selected_shop_id');

    try {
      isLoading(true);
      final url = Uri.parse('${Api.ApiUrl}/promotions?shop_id=$selectedShopId');
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final promotionsData = (jsonResponse['data'] as List)
            .map((item) => Promotion.fromJson(item))
            .toList();

        promotionsList.assignAll(promotionsData);

        if (promotionsData.isNotEmpty) {
          final promotionId = promotionsData.first.promotionId;
          print('Promotion ID: $promotionId');
          GetStorage().write('promotion_id', promotionId);
        }
      } else {
        print('Failed to load promotions: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching promotions: $e");
    } finally {
      isLoading(false);
    }
    isLaundrySelected.value = false;
    isOfferSelected.value = true;
    isGrocerySelected.value = false;
    isAjSelected.value = false;
    selectedIndex.value = 2;
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
  Future<void> fetchAjProducts() async {
    isLoading.value = true;
    try {
      final response =
      await http.get(Uri.parse("https://grocery-dev.greendomains.in/api/products/aj"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          List<dynamic> productList = data['data'];
          ajProducts.value =
              productList.map((product) => AjProduct.fromJson(product)).toList();
        } else {
          Get.snackbar('Error', 'Failed to load products');
        }
      } else {
        Get.snackbar('Error', 'Failed to connect to the API');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
    isLaundrySelected.value = false;
    isOfferSelected.value = false;
    isGrocerySelected.value = false;
    isAjSelected.value = true;
    selectedIndex.value = 3;
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    await fetchPopularProducts();
    await fetchDiscountProducts();
    await fetchPopularCategories();



    if (selectedIndex.value == 3) {
      await fetchAjProducts();
    } else if (selectedIndex.value == 2) {
      await fetchPromotions();
    } else if (selectedIndex.value == 1) {
      await fetchLaundry();
    } else {
      await fetchCategories();
    }

    isLoading.value = false;
  }
}