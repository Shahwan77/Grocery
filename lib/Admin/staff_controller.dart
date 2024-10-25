import 'package:get/get.dart';

class StaffController extends GetxController {
  var selectedStaff = ''.obs;

  void clearSelectedStaff() {
    selectedStaff.value = '';
  }

  void setSelectedStaff(String staffName) {
    selectedStaff.value = staffName;
  }
}
