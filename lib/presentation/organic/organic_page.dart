import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/apiClient/api.dart';
import '../../data/models/models.dart';
import '../Cart/cart_controller.dart';
import '../Products/products_controller.dart';
import 'all_organic_food.dart';

class OrganicPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final ProductsController productsController = Get.put(ProductsController());

  Future<List<Models>> fetchSubcategories() async {
    final response = await http.get(Uri.parse('${Api.BaseUrl}/api/product-subcategories?category_id=2'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> subcategoriesJson = data['data'];
      return subcategoriesJson.map((json) => Models.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Models>>(
      future: fetchSubcategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No subcategories available'));
        } else {
          final subcategories = snapshot.data!;

          return DefaultTabController(
            length: subcategories.length + 1,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.green.shade800,
                title: Text('ORGANIC & HEALTHY FOOD', style: TextStyle(color: Colors.white)),
              ),
              body: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.green.shade800,
                      labelPadding: EdgeInsets.all(8),
                      isScrollable: true,
                      tabs: [
                        Tab(text: 'All'),
                        ...subcategories.map((subcategory) => Tab(text: subcategory.name)).toList(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AllOrganicFood(),
                        ...subcategories.map((subcategory) {
                          return SubcategoryPage(subcategory: subcategory);
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class SubcategoryPage extends StatelessWidget {
  final Models subcategory;

  SubcategoryPage({required this.subcategory});
  final ProductsController productsController = Get.put(ProductsController());


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Models>>(
      future: productsController.fetchRiceCakes(subcategory.id),  // Fetch products for this subcategory
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available for ${subcategory.name}'));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20.0,
              mainAxisExtent: 200,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Column(
                children: [
                  IntrinsicHeight(
                    child: Container(
                      width: 160, // Adjust the width as needed
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Handle favorite toggle
                                  },
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.green.shade800,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: product.image.isNotEmpty
                                ? Image.network(
                              'https://grocery-dev.greendomains.in/storage/images/products/${product.image}',
                              fit: BoxFit.cover,
                              height: 80, // Adjust image size
                              width: 80,
                            )
                                : Icon(
                              Icons.image,
                              size: 80,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              product.name,
                              style: TextStyle(fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.price.isNotEmpty ? product.price : '00', // Default price
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle add to cart
                                  },
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
