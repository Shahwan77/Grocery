import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFEB1C23),
        statusBarIconBrightness: Brightness.light,
      ),
      surfaceTintColor: Colors.white,
      backgroundColor: Color(0xFFEB1C23),
      elevation: 0,
      toolbarHeight: toolbarHeight,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 64.h,
                width: 74.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png',width: 40.w,),
                    Text('Grocery',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
              Container(
                height: 64.h,
                width: 74.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/laundry2.png',width: 40.w,),
                    Text('Laundry',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
              Container(
                height: 64.h,
                width: 74.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/offers2.png',width: 40.w,),
                    Text('Offers',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
              Container(
                height: 64.h,
                width: 74.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/aj3.png',width: 70.w,height: 50,),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 6),
                      child: Text('AJ',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}



