
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/home_screen/page/home_page.dart';
import 'package:grocery/routes/app_routes.dart';

import '../../Language Selection/language_selection.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _init();
  }
  Future<void> _init() async {
    await Future.delayed(Duration(seconds: 4));

    bool isLoggedIn = box.read('isLoggedIn') ?? false;
    bool isSignUp = box.read('isSignUp') ?? false;

    if (isSignUp) {
      Get.offAll(() => CustomBottomNavBar());
    } else if (isLoggedIn) {
      Get.offAll(() => CustomBottomNavBar());
    } else {
      Get.offAll(() => WelcomePage());
    }
  }
  // Future<void> _init() async {
  //   await Future.delayed(
  //     Duration(seconds: 4),
  //   );
  //  Get.offNamed('/language');
  // }
}
