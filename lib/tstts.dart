// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class PaymentGatewayScreen extends StatelessWidget {
//   final String totalAmount = "100.00"; // Example amount
//   final String email = "example@example.com"; // User email
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Telr Payment'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             openTelrPaymentGateway();
//           },
//           child: Text('Pay Now'),
//         ),
//       ),
//     );
//   }
//
//   void openTelrPaymentGateway() async {
//     final paymentRequest = preparePaymentRequest();
//     final response = await sendPaymentRequest(paymentRequest);
//
//     if (response != null) {
//       // Handle the response from Telr
//       print('Response: $response');
//       // Navigate to ResultController or handle the response accordingly
//     }
//   }
//
//   Map<String, dynamic> preparePaymentRequest() {
//     return {
//       "key": "6QsRj-Wxw7S@R6sz",
//       "store": "22134",
//       "appId": "123456789",
//       "appName": "YOUR_APP_NAME",
//       "appUser ": "123456",
//       "appVersion": "0.0.1",
//       "transTest": "1",
//       "transType": "auth",
//       "transClass": "paypage",
//       "transCartid": DateTime.now().millisecondsSinceEpoch.toString(),
//       "transDesc": "Test API",
//       "transCurrency": "AED",
//       "transAmount": totalAmount,
//       "transLanguage": "en",
//       "billingEmail": email,
//       "billingFName": "Hany",
//       "billingLName": "Sakr",
//       "billingTitle": "Mr",
//       "city": "Dubai",
//       "country": "AE",
//       "region": "Dubai",
//       "address": "line 1",
//       "billingPhone": "8785643",
//     };
//   }
//
//   Future<Map<String, dynamic>?> sendPaymentRequest(Map<String, dynamic> paymentRequest) async {
//     final url = 'https://secure.telr.com/gateway/mobile.xml'; // Replace with the correct endpoint
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(paymentRequest),
//     );
//
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       print('Failed to process payment: ${response.body}');
//       return null;
//     }
//   }
// }
//
// class ResultScreen extends StatelessWidget {
//   final Map<String, dynamic> response;
//
//   ResultScreen({required this.response});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment Result'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Message: ${response['message']}'),
//             Text('Trace: ${response['trace']}'),
//             Text('Status: ${response['status']}'),
//             Text('AVS: ${response['avs']}'),
//             Text('Code: ${response['code']}'),
//             Text('Card Code: ${response['cardCode']}'),
//             Text('Card Last 4: ${response['cardLast4']}'),
//             Text('Transaction Reference: ${response['tranRef']}'),
//           ],
//         ),
//       ),
//     );
//   }
// }