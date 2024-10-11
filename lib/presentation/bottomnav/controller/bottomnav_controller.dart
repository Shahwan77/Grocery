import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkstatus();
  }

  void _checkstatus() {
    final String? status = box.read('status');
    if (status == '4') {
      selectedIndex.value = 4;
    } else {
      selectedIndex.value = 0;
    }
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
