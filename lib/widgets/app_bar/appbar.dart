import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/widgets/drawer/cus_drawer.dart';

import '../../presentation/Scanner/scanner_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;

  const CustomAppBar({
    Key? key,
    this.toolbarHeight = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: toolbarHeight,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.grey.shade100,
                ),
                child: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: SvgPicture.asset(
                        'assets/menu1.svg',
                        color: Colors.green.shade800,
                        height: 30,
                        width: 30,
                      ),
                      onPressed: () {
                        _openCustomDrawer(context);
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 5.w),
              Image.asset(
                'assets/gro1.png',
                height: 40.h,
                width: 40.w,
              ),
              Icon(
                Icons.location_on,
                color: Colors.green.shade800,
                size: 34.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '24 | United Arab Emirates |',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '13 | 4',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    '0.00',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'AED',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon:
                        Icon(Icons.search, color: Colors.green.shade800),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 15.w,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () async {
                  String? scannedData = await Get.to(() => ScannerPage());
                  if (scannedData != null) {
                    print("Scanned data: $scannedData");
                    // Handle the scanned data here
                  }
                },
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  height: 46.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey.shade100,
                  ),
                  child: Icon(
                    Icons.document_scanner_rounded,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openCustomDrawer(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return CustomDrawerOverlay();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

void _openCustomDrawer(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return CustomDrawerOverlay();
      },
    ),
  );
}

class CustomDrawerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black54, // Background shade
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 250.w,
            child: CusDrawer(), // Your custom drawer widget
          ),
        ),
      ),
    );
  }
}
