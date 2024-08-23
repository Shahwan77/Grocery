import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/home_screen/page/home_page.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        //initialRoute:AppRoutes.SplashScreen,
       // getPages: AppPages.Lists,
        debugShowCheckedModeBanner: false,
        home: CustomBottomNavBar(),
      ),
    );
  }
}

