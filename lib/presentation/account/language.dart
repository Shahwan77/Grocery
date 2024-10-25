import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/button/button.dart';
import '../Language Selection/language_controller.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({Key? key}) : super(key: key);

  final WelcomeController controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 26.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                controller.selectLanguageText,
                style: GoogleFonts.roboto(
                    color: Colors.black, fontSize: 20.sp),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  controller.selectLanguage('English');
                  Get.back();
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
                            fontSize: 20.sp,
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
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                )),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  controller.selectLanguage('Arabic');
                  Get.back();
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
                            fontSize: 20.sp,
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
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
