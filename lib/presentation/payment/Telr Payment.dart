// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:xml/xml.dart';
//
// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   // Controllers for text fields
//   final TextEditingController _amount = TextEditingController();
//   final TextEditingController _currency = TextEditingController();
//
//   // Method to generate XML and process payment
//   void _processPayment() {
//     final builder = XmlBuilder();
//     builder.processing('xml', 'version="1.0"');
//     builder.element('mobile', nest: () {
//       builder.element('store', nest: () {
//         builder.text('22134');
//       });
//       builder.element('key', nest: () {
//         builder.text('6QsRj-Wxw7S@R6sz');
//       });
//
//       builder.element('device', nest: () {
//         builder.element('type', nest: () {
//           builder.text('iOS');
//         });
//         builder.element('id', nest: () {
//           builder.text('12345'); // Replace with your actual device id
//         });
//       });
//
//       builder.element('app', nest: () {
//         builder.element('name', nest: () {
//           builder.text('Telr');
//         });
//         builder.element('version', nest: () {
//           builder.text('1.1.6');
//         });
//         builder.element('user', nest: () {
//           builder.text('2');
//         });
//         builder.element('id', nest: () {
//           builder.text('123');
//         });
//       });
//
//       // Transaction details
//       builder.element('tran', nest: () {
//         builder.element('test', nest: () {
//           builder.text('1');
//         });
//         builder.element('type', nest: () {
//           builder.text('auth');
//         });
//         builder.element('class', nest: () {
//           builder.text('paypage');
//         });
//         builder.element('cartid', nest: () {
//           builder.text(100000000 + Random().nextInt(999999999));
//         });
//         builder.element('description', nest: () {
//           builder.text('Test for Mobile API order');
//         });
//         builder.element('currency', nest: () {
//           builder.text(_currency.text);
//         });
//         builder.element('amount', nest: () {
//           builder.text(_amount.text);
//         });
//         builder.element('language', nest: () {
//           builder.text('en');
//         });
//         builder.element('firstref', nest: () {
//           builder.text('first');
//         });
//         builder.element('ref', nest: () {
//           builder.text('null');
//         });
//       });
//
//       // Billing details
//       builder.element('billing', nest: () {
//         builder.element('name', nest: () {
//           builder.element('title', nest: () {
//             builder.text('');
//           });
//           builder.element('first', nest: () {
//             builder.text('Div');
//           });
//           builder.element('last', nest: () {
//             builder.text('V');
//           });
//         });
//
//         builder.element('address', nest: () {
//           builder.element('line1', nest: () {
//             builder.text('Dubai');
//           });
//           builder.element('city', nest: () {
//             builder.text('Dubai');
//           });
//           builder.element('region', nest: () {
//             builder.text('');
//           });
//           builder.element('country', nest: () {
//             builder.text('AE');
//           });
//         });
//
//         builder.element('phone', nest: () {
//           builder.text('551188269');
//         });
//         builder.element('email', nest: () {
//           builder.text('test@telr.com');
//         });
//       });
//     });
//
//     final paymentXml = builder.buildDocument();
//     print(paymentXml.toXmlString(pretty: true));
//     _pay(paymentXml);
//   }
//
//   // Mock payment method
//   void _pay(XmlDocument xml) {
//     // Replace this with your API call logic
//     print("Payment XML: ${xml.toXmlString(pretty: true)}");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Payment initiated successfully")),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Payment Page"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _amount,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 13, color: Colors.red),
//               decoration: InputDecoration(
//                 hintText: "Enter Amount",
//                 errorStyle: TextStyle(fontSize: 10),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _currency,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 13),
//               decoration: InputDecoration(
//                 hintText: "Enter Currency",
//                 errorStyle: TextStyle(fontSize: 10),
//               ),
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: _processPayment,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.grey,
//                 padding: EdgeInsets.zero,
//               ),
//               child: Container(
//                 height: 50,
//                 alignment: Alignment.center,
//                 child: Text(
//                   'PAY',
//                   style: TextStyle(color: Colors.black, fontSize: 12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
