import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Categories/see%20all_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/category_model.dart';
import 'categories_detail.dart';
import '../home_screen/models/categories_model.dart';

// Controller to manage the categories
class CategoryController extends GetxController {
  var categories = <Category>[].obs; // Observable list of categories
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCategories(); // Fetch categories when the controller is initialized
    super.onInit();
  }

  Future<void> fetchCategories() async {
    const url = 'https://grocery-dev.greendomains.in/api/product-categories';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        categories.value = data.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Stop the loader once data is fetched
    }
  }
}

class CategoriesPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              GestureDetector(
                child: Text(
                  "See all",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: Colors.green.shade800,
                  ),
                ),
                onTap: () {
                  // Navigate to the "See All" page
                  Get.to(SeeAllPage());
                },
              ),
            ],
          ),
        ),
        Obx(() {
          if (categoryController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (categoryController.categories.isEmpty) {
            return Center(child: Text("No categories found."));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 0.7,
              ),
              itemCount: categoryController.categories.length,
              itemBuilder: (context, index) {
                final category = categoryController.categories[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailPage( categoryId: category.id.toString(),)); // Pass the Category object
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://grocery-dev.greendomains.in/storage/images/categories/${category.image}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        category.name,
                        style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ],
    );
  }
}
