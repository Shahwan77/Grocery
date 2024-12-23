import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/apiClient/api.dart';
import '../Language Selection/language_controller.dart';
import '../home_screen/controller/home_controller.dart';
import '../home_screen/models/categories_model.dart';
import 'categories_detail.dart';

class CategoriesNavbar extends StatelessWidget {
  const CategoriesNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController categoryController = Get.put(HomeController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    String type = GetStorage().read('selectedButton') ?? 'grocery';
    Future<void> fetchData() async {
      try {
        if (type == 'grocery') {
          await categoryController.fetchCategories(); // Fetch grocery categories
        } else if (type == 'laundry') {
          await categoryController.fetchLaundry(); // Fetch laundry items
        } else {
          throw Exception("Unknown type");
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFEB1C23),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          languagecontroller.categoriesText,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (categoryController.categories.isEmpty) {
            if (type == 'laundry') {
              return Center(child: Text("No laundry items found."));
            } else if (type == 'grocery') {
              return Center(child: Text("No grocery items found."));
            } else {
              return Center(child: Text("No categories found."));
            }
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 40.0,
                  mainAxisExtent: ScreenUtil().screenWidth >600?270:180
              ),
              itemCount: categoryController.categories.length,
              itemBuilder: (context, index) {
                final category = categoryController.categories[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailPage(
                      categoryId: category.id.toString(),
                      categoryName: category.name,
                    ));
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 144.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFEB1C23), width: 1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: category.image != null && category.image!.isNotEmpty
                                    ? Image.network(
                                  '${Api.ImageUrl}/categories/${category.image}',
                                  fit: BoxFit.cover,
                                  height: 80.h,
                                  width: 80.w,
                                  errorBuilder: (context, error, stackTrace) => Icon(
                                    Icons.hide_image_outlined,
                                    size: 94.sp,
                                    color: Colors.grey,
                                  ),
                                )
                                    : Icon(
                                  Icons.hide_image_outlined,
                                  size: 90.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 26.h,
                              decoration: BoxDecoration(
                                  color: Color(0xFFEB1C23),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(18.r),bottomLeft: Radius.circular(18.r))
                              ),
                              child: Center(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                          fontSize: 10.sp, color: Colors.white),
                                      maxLines: 4,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
