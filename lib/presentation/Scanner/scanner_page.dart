import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/Scanner/scanner_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerPage extends StatelessWidget {
  final ScannerController controller = Get.put(ScannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: QRView(
              cameraFacing: CameraFacing.back,
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10.r,
                borderLength:30.h,
                borderWidth: 10.w,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Obx(
                    () => Text(
                  controller.qrText.value.isNotEmpty
                      ? 'Scan result: ${controller.qrText.value}'
                      : 'Scan a code',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
