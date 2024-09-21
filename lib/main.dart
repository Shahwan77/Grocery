import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/routes/app_pages.dart';
import 'package:grocery/routes/app_routes.dart';

Future<void> main() async {
  await GetStorage.init();
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
       //home: BigBazr(),
        initialRoute:AppRoutes.BottomNav,
       getPages: AppPages.Lists,
        debugShowCheckedModeBanner: false,
       // home: CustomBottomNavBar(),
      ),
    );
  }
}

