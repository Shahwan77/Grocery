import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/home_screen/models/categories_model.dart';
import 'package:grocery/presentation/organic/Rice_cakes.dart';
import 'package:grocery/presentation/organic/all_organic_food.dart';
import 'package:grocery/presentation/organic/cereals.dart';
import 'package:grocery/presentation/organic/dairy_eggs.dart';
import 'package:grocery/presentation/organic/organic.dart';
import 'package:grocery/presentation/organic/spread.dart';
import '../Cart/cart_controller.dart';
import 'organic_model.dart';

class OrganicPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 16, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.green.shade800,
          title: Text('ORGANIC & HEALTHY FOOD',style: TextStyle(color: Colors.white),),
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
                  Tab(text: 'Rice cakes'),
                  Tab(text: 'Dairy & Eggs'),
                  Tab(text: 'Spread'),
                  Tab(text: 'Organic items'),
                  Tab(text: 'Cereals'),
                  Tab(text: 'Breads'),
                  Tab(text: 'Herbs & Spices'),
                  Tab(text: 'Juice'),
                  Tab(text: 'Nuts'),
                  Tab(text: 'Bars'),
                  Tab(text: 'Sweetener'),
                  Tab(text: 'Oil & Ghee'),
                  Tab(text: 'Paste & Noodles'),
                  Tab(text: 'Can food'),
                  Tab(text: 'Rice & Lentils'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // First tab content
                  AllOrganicFood(categoryId: 2,),
                  // Second tab content
                  RiceCakes(),
                  // Third tab content
                  DairyEggs(),
                  // Fourth tab content
                  Spread(),
                  // Fifth tab content
                  Organic(),
                  // Sixth tab content
                  Cereals(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
