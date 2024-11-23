import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/notification_model.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final isLoading = true.obs;
  final String? token = GetStorage().read('access_token');
  final int? userId = GetStorage().read('user_id'); // Fetch user_id from storage
  final String? selectedStoreId = GetStorage().read('selected_shop_id');
  Future<void> fetchNotifications() async {
    if (userId == null) {
      print('User ID is not available');
      return;
    }

    isLoading.value = true;
    final url = Uri.parse(
        '${Api.ApiUrl}/notifications?shop_id=$selectedStoreId&user_id=$userId'
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          notifications.value = (responseData['data'] as List)
              .map((item) => NotificationModel.fromJson(item))
              .toList();
        }
      } else {
        print('Failed to load notifications');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markNotificationAsRead(int notificationId) async {
    final String? token = GetStorage().read('access_token');

    try {
      final response = await http.post(
        Uri.parse("${Api.ApiUrl}/notifications"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "notification_id": notificationId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true) {
          //Get.snackbar('Success', jsonData['message'], snackPosition: SnackPosition.BOTTOM);
        } else {
          print('Failed to mark notification as read');
        }
      } else {
        print('Failed to mark notification as read');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }
}
