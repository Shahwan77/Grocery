import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Bakery Products/bakery_product_page.dart';
import '../Dairy & Eggs/dairy_eggs.dart';
import '../Fruits & Vegetables/fruits_vegetables.dart';
import '../Tea & Coffee/tea_coffee.dart';
import '../ice cream/ice_page.dart';
import '../organic/organic_page.dart';

class DetailPage extends StatelessWidget {
  final String categoryId;

  DetailPage({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    // Define a mapping from categoryId to the respective page
    Widget page;
    switch (categoryId) {
      case '1': // Assuming 1 is the ID for 'FROZEN ICE CREAM'
        page = IceCreamPage();
        break;
      case '2': // Assuming 2 is the ID for 'ORGANIC & HEALTHY FOOD'
        page = OrganicPage();
        break;
      case '3': // Assuming 3 is the ID for 'BAKERY PRODUCTS'
        page = BakeryProductPage();
        break;
      case '4': // Assuming 4 is the ID for 'FRUITS & VEGETABLES'
        page = FruitsVegetables();
        break;
      case '5': // Assuming 5 is the ID for 'DAIRY & EGGS'
        page = DairyEggs();
        break;
      case '6': // Assuming 6 is the ID for 'TEA & COFFEE'
        page = TeaCoffee();
        break;
      default:
      // Default page for unknown categories
        page = Scaffold(
          appBar: AppBar(
            title: Text(
              'Unknown Category',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.green.shade800,
          ),
          body: Center(
            child: Text(
              'Category not found',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
            ),
          ),
        );
        break;
    }

    return page;
  }
}
