// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// class ScannerController extends GetxController {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   var qrText = ''.obs;
//
//   @override
//   void onClose() {
//     controller?.dispose();
//     super.onClose();
//   }
//
//   void onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       qrText.value = scanData.code ?? '';
//       controller.pauseCamera(); // Optionally pause the camera after scanning
//       Get.back(result: qrText.value); // Return to the previous page with the scanned data
//     });
//   }
// }
