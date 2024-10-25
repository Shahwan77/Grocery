import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import this for localization
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Language%20Selection/TranslationService.dart';
import 'package:grocery/presentation/Language%20Selection/language_selection.dart';
import 'package:grocery/routes/app_pages.dart';
import 'package:grocery/routes/app_routes.dart';
import 'Admin/orders_list.dart';
import 'l10n/app_localizations.dart'; // Import your localization class

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCz-cOyLCXi6EcdJT9ZVKSO3IBOUnz8LqU",
        appId: "1:923637485364:android:65ee82c180a36893045f61",
        messagingSenderId: "923637485364",
        projectId: "grocery-4a4ff",
      )
  );
  await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        translations: TranslationService(),
        locale: Locale('en'),
        fallbackLocale: Locale('en'),
        localizationsDelegates: const [ // Mark as const
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [ // Mark as const
          Locale('ar'), // Arabic
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        title: 'Flutter Demo',
         //home: OrdersList(),
         initialRoute: AppRoutes.Splash,
         getPages: AppPages.Lists,
        debugShowCheckedModeBanner: false, // Remove banner
      ),
    );
  }
}
