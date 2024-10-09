import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;  // Default is 0 for HomePage
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkToken();
  }

  // Method to check if the token exists
  void _checkToken() {
    final String? token = box.read('access_token');
    if (token != null) {
      selectedIndex.value = 4;  // Set to CartPage index (4) if token is not null
    } else {
      selectedIndex.value = 0;  // Set to HomePage index (0) if token is null
    }
  }

  // Method to update the selected index
  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
