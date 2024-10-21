import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WelcomeController extends GetxController {
  var selectedLanguage = 'English'.obs;

  void selectLanguage(String language) {
    selectedLanguage.value = language;
    update();
  }

  // Define the text translations for English and Arabic
  String get welcomeText =>
      selectedLanguage.value == 'English' ? 'WELCOME' : 'أهلاً وسهلاً';
  String get selectLanguageText =>
      selectedLanguage.value == 'English' ? 'Select Language' : 'اختر اللغة';
  String get startedText =>
      selectedLanguage.value == 'English' ? 'Get Started' : 'ابدأ';
  String get welcometoText => selectedLanguage.value == 'English'
      ? 'Welcome To Liveasy'
      : 'مرحبًا بك في Liveasy';
  String get sendotpText =>
      selectedLanguage.value == 'English' ? 'Send OTP' : 'إرسال OTP';
  String get enternumberText => selectedLanguage.value == 'English'
      ? 'Enter Phone Number'
      : 'أدخل رقم الهاتف';
  String get numberText => selectedLanguage.value == 'English'
      ? 'A 6-digit OTP will be sent via SMS to verify your number'
      : 'سيتم إرسال OTP مكون من 6 أرقام عبر SMS للتحقق من رقمك';
  String get otpsentText =>
      selectedLanguage.value == 'English' ? 'OTP sent to' : 'تم إرسال OTP إلى';
  String get changeText =>
      selectedLanguage.value == 'English' ? 'change' : 'تغيير';
  String get verificationText =>
      selectedLanguage.value == 'English' ? 'OTP Verification' : 'التحقق OTP';
  String get continueText =>
      selectedLanguage.value == 'English' ? 'CONTINUE' : 'استمر';
  String get profileText => selectedLanguage.value == 'English'
      ? 'Please select your profile'
      : 'يرجى اختيار ملفك الشخصي';
  String get shipperText =>
      selectedLanguage.value == 'English' ? 'Shipper' : 'المرسل';
  String get transporterText =>
      selectedLanguage.value == 'English' ? 'Transporter' : 'النقل';
  String get subText => selectedLanguage.value == 'English'
      ? 'Lorem ipsum dolor sit amet,\nconsectetur adipiscing'
      : 'لوريم إيبسوم دولور سيت أميت,\nكونسكتتور أديبسكينج';

  String get englishText => 'English';
  String get arabicText => 'العربية';
}