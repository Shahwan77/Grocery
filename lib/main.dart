import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/Language%20Selection/language_selection.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/routes/app_pages.dart';
import 'package:grocery/routes/app_routes.dart';
import 'package:grocery/tst12.dart';
import 'package:grocery/tstts.dart';

import 'kkk.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCz-cOyLCXi6EcdJT9ZVKSO3IBOUnz8LqU",
        appId:  "1:923637485364:android:65ee82c180a36893045f61",
        messagingSenderId: "923637485364",
        projectId: "grocery-4a4ff",)
  );
  await FirebaseAppCheck.instance.activate();
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
       // home: WelcomePage(),
        initialRoute:AppRoutes.Splash,
       getPages: AppPages.Lists,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        color: Colors.white,
        backgroundColor: Colors.blueAccent,
        //buttonBackgroundColor: Colors.white,
        height: 60,
        items: <Widget>[
          Icon(Icons.add, size: 30, color: Colors.red),
          Icon(Icons.list, size: 30, color: Colors.red),
          Icon(Icons.compare_arrows, size: 30, color: Colors.red),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Page: $_page',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Programmatically navigate to page 1
                  final CurvedNavigationBarState? navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState?.setPage(1);
                },
                child: Text('Go To Page 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

