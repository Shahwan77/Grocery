// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class AuthService {
//   static const String baseUrl = 'https://grocery-dev.greendomains.in/api';
//
//   Future<Map<String, dynamic>> resetPassword(
//       String mobileNo, String newPassword, String confirmPassword) async {
//     final url = Uri.parse('$baseUrl/reset-password');
//
//     final body = {
//       'mobile_no': mobileNo,
//       'new_password': newPassword,
//       'new_password_confirmation': confirmPassword,
//     };
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(body),
//       );
//
//       if (response.statusCode == 200) {
//         return json.decode(response.body); // Successful response
//       } else {
//         return {'error': json.decode(response.body)['message']};
//       }
//     } catch (e) {
//       return {'error': 'Failed to connect to server'};
//     }
//   }
// }
//
// class ResetPasswordController extends GetxController {
//   final AuthService _authService = AuthService();
//   RxBool isLoading = false.obs;
//
//   Future<void> resetPassword(String mobileNo, String newPassword, String confirmPassword) async {
//     isLoading.value = true;
//
//     final result = await _authService.resetPassword(mobileNo, newPassword, confirmPassword);
//     isLoading.value = false;
//
//     if (result.containsKey('error')) {
//       Get.snackbar('Error', result['error'], snackPosition: SnackPosition.BOTTOM);
//     } else {
//       Get.snackbar('Success', 'Password reset successfully!', snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
//
//
// class ResetPasswordPage extends StatelessWidget {
//   final ResetPasswordController controller = Get.put(ResetPasswordController());
//
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reset Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: mobileController,
//               decoration: InputDecoration(labelText: 'Mobile Number'),
//               keyboardType: TextInputType.phone,
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'New Password'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: confirmPasswordController,
//               decoration: InputDecoration(labelText: 'Confirm Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             Obx(() => controller.isLoading.value
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: () {
//                 controller.resetPassword(
//                   mobileController.text,
//                   passwordController.text,
//                   confirmPasswordController.text,
//                 );
//               },
//               child: Text('Reset Password'),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
