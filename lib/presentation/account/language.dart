import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
              height: 22.h,
              width: 26.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFFEB1C23),
                  size: 20.sp,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Color(0xFFEB1C23),
          title: Text(
            controller.languageText, // Use language text from controller
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 40.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Color(0xFFEB1C23),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
          child: Column(
            children: [
              Obx(() => LanguageOption(
                language: "English",
                isSelected: controller.selectedLanguage.value == 'English',
                onTap: () => controller.selectLanguage('English'),
              )),
              SizedBox(height: 20.h),
              Obx(() => LanguageOption(
                language: 'عربي',
                isSelected: controller.selectedLanguage.value == 'Arabic',
                onTap: () => controller.selectLanguage('Arabic'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    Key? key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? Color(0xFFEB1C23) : Colors.grey,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
          ],
        ),
        child: Text(
          language,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            color:Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
