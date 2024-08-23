// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
//
// class HomeController extends GetxController {
//   // Observable lists for items
//   var items = <Item>[].obs;
//   var popularItems = <PopularItem>[].obs;
//   var mstImage = <String>[].obs;
//   var msttext = <String>[].obs;
//   var mstPrice = <String>[].obs;
//   var popImage = <String>[].obs;
//   var poptext = <String>[].obs;
//   var popPrice = <String>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize your data here
//     fetchItems();
//   }
//
//   void fetchItems() {
//     // Sample data for demonstration
//     items.addAll([
//       Item('Item 1', 'assets/item1.png'),
//       Item('Item 2', 'assets/item2.png'),
//       // Add more items
//     ]);
//
//     popularItems.addAll([
//       PopularItem('Popular 1', 'assets/popular1.png'),
//       PopularItem('Popular 2', 'assets/popular2.png'),
//       // Add more popular items
//     ]);
//
//     mstImage.addAll([
//       'assets/mst1.png',
//       'assets/mst2.png',
//       // Add more images
//     ]);
//
//     msttext.addAll([
//       'MST 1',
//       'MST 2',
//       // Add more texts
//     ]);
//
//     mstPrice.addAll([
//       '10.00 AED',
//       '20.00 AED',
//       // Add more prices
//     ]);
//
//     popImage.addAll([
//       'assets/pop1.png',
//       'assets/pop2.png',
//       // Add more images
//     ]);
//
//     poptext.addAll([
//       'Pop 1',
//       'Pop 2',
//       // Add more texts
//     ]);
//
//     popPrice.addAll([
//       '15.00 AED',
//       '25.00 AED',
//       // Add more prices
//     ]);
//   }
// }
//
// class Item {
//   final String name;
//   final String imagePath;
//
//   Item(this.name, this.imagePath);
// }
//
// class PopularItem {
//   final String text;
//   final String imagePath1;
//
//   PopularItem(this.text, this.imagePath1);
// }
