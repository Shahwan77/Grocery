import 'package:get/get.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/sign_in_screen/page/login_page.dart';
import 'package:grocery/presentation/sign_up_screen/page/signup_page.dart';
import 'package:grocery/presentation/splash_screen/models/splash_page.dart';
import 'package:grocery/routes/app_routes.dart';

class AppPages {
  static var Lists = [
    GetPage(
      name: AppRoutes.Splash,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.SignUp,
      page: () => SignupPage(),
    ),
    GetPage(
      name: AppRoutes.BottomNav,
      page: () => CustomBottomNavBar(),
    ),
  ];
}
