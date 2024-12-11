import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/button/button.dart';
import '../shop.dart';
import 'language_controller.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  final WelcomeController controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: 360.h,
            width: 320.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 6.0,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.normal,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/logo.png'), width: 100.w),
                // Dynamic localized text
                Text(AppLocalizations.of(context)!.hello),
                SizedBox(height: 20),
               Text(
                  controller.selectLanguageText,
                  style: GoogleFonts.roboto(
                      color: Colors.grey, fontSize: 26),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectLanguage('English');
                        print("LANGUAGE: ${GetStorage().read('selectedLanguage') ?? 'English'}");
                      },
                      child: Obx(() => Container(
                        width: 120.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: controller.selectedLanguage.value ==
                                'English'
                                ? Color(0xFFEB1C23)
                                : Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                controller.englishText,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: controller
                                      .selectedLanguage.value ==
                                      'English'
                                      ? Color(0xFFEB1C23)
                                      : Colors.grey,
                                ),
                              ),
                              if (controller.selectedLanguage.value ==
                                  'English')
                                Icon(
                                  Icons.check_circle,
                                  color: Color(0xFFEB1C23),
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      )),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        controller.selectLanguage('Arabic');
                        print("LANGUAGE: ${GetStorage().read('selectedLanguage')??'English'}");
                      },
                      child: Obx(() => Container(
                        width: 120.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: controller.selectedLanguage.value ==
                                'Arabic'
                                ? Color(0xFFEB1C23)
                                : Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                controller.arabicText,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: controller
                                      .selectedLanguage.value ==
                                      'Arabic'
                                      ? Color(0xFFEB1C23)
                                      : Colors.grey,
                                ),
                              ),
                              if (controller.selectedLanguage.value ==
                                  'Arabic')
                                Icon(
                                  Icons.check_circle,
                                  color: Color(0xFFEB1C23),
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Button(
                  color: Color(0xFFEB1C23),
                  text: Text(
                      controller.startedText,
                      style: GoogleFonts.roboto(
                          fontSize: 18, color: Colors.white),
                    ),
                  ontap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectStorePage(),));
                    print("LANGUAGE: ${GetStorage().read('selectedLanguage') ?? 'English'}");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
