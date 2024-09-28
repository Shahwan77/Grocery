import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/presentation/splash_screen/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashcontroller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png',width: 200.w,height: 100.h,),
          SizedBox(height: 5.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('GROCERY',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700),),
              Text(' SERVICES',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,color: Colors.red),),
            ],
          ),
          Text('We make your shopping simple')
        ],
      ),
    );
  }
}
