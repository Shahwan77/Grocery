import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StaffController extends GetxController {
  var selectedStaff = ''.obs;
  var staffList = <Staff>[].obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    fetchStaffs();
    super.onInit();
  }

  void clearSelectedStaff() {
    selectedStaff.value = '';
  }

  void setSelectedStaff(String staffId) {
    selectedStaff.value = staffId;
  }

  Future<void> fetchStaffs() async {
    final String? token = box.read('access_token');
    final response = await http.get(
      Uri.parse(
          'https://grocery-dev.greendomains.in/api/admin/staffs?shop_id=1'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        List<dynamic> staffData = data['data'];
        staffList.value =
            staffData.map((staff) => Staff.fromJson(staff)).toList();
      }
    } else {
      throw Exception('Failed to load staff data');
    }
  }

  Future<void> assignStaffToOrder(String orderId, String staffId) async {
    final String? token = box.read('access_token');
    final response = await http.post(
      Uri.parse('https://grocery-dev.greendomains.in/api/admin/orders/staff'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'order_id': orderId,
        'staff_id': int.parse(staffId),
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      if (data['success']) {
        print('Staff assigned successfully');
        Get.snackbar('Success', data['message']);
      } else {
        print('Failed to assign staff: ${data['message']}');
      }
    } else {
      print('Failed to assign staff: ${response.statusCode}');
    }
  }
}
  class Staff {
  final int id;
  final String name;

  Staff({required this.id, required this.name});

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      name: json['name'],
    );
  }
}
