// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LanguageController extends GetxController {
//   var selectedLocale = Locale('en').obs;
//
//   void changeLanguage(String languageCode) {
//     var locale = Locale(languageCode);
//     Get.updateLocale(locale);
//   }
// }
//
// class HomePage extends StatelessWidget {
//   final LanguageController languageController = Get.put(LanguageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(S.of(context).title),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(S.of(context).description),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               languageController.changeLanguage('en');  // Switch to English
//             },
//             child: Text('Switch to English'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               languageController.changeLanguage('ar');  // Switch to Arabic
//             },
//             child: Text('Switch to Arabic'),
//           ),
//         ],
//       ),
//     );
//   }
// }
