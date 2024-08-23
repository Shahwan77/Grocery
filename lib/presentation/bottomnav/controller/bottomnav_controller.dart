import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Observable for the selected index
  var selectedIndex = 0.obs;

  // Method to update the selected index
  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
