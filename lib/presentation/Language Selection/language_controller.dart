import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeController extends GetxController {
  var selectedLanguage = ''.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();

    // selectedLanguage.value = box.read('selectedLanguage') ?? 'English';
    //
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (selectedLanguage.value == 'Arabic') {
    //     Get.updateLocale(Locale('ar'));
    //   } else {
    //     Get.updateLocale(Locale('en'));
    //   }
    // });
  }




  void selectLanguage(String language) {
    selectedLanguage.value = language;
    box.write('selectedLanguage', language);

    if (language == 'English') {
      Get.updateLocale(Locale('en'));
    } else if (language == 'Arabic') {
      Get.updateLocale(Locale('ar'));
    }
  }

  String get arabicText => 'Arabic';
  String get englishText => 'English';
  String get selectLanguageText => 'select_language'.tr;
  String get welcomeText => 'welcome'.tr;
  String get startedText => 'get_started'.tr;
  String get groceryText => 'grocery'.tr;
  String get GroceryText => 'Grocery'.tr;
  String get laundryText => 'laundry'.tr;
  String get offersText => 'offers'.tr;
  String get ajText => 'aj'.tr;
  String get searchText => 'search_here'.tr;
  String get seeallText => 'see_all'.tr;
  String get categoriesText => 'categories'.tr;
  String get customizedcakeText => 'customized_cake'.tr;
  String get mostText => 'most_popular_categories'.tr;
  String get popularText => 'popular_products'.tr;
  String get topText => 'top_discount_products'.tr;
  String get cartText => 'cart'.tr;
  String get continueText => 'continue'.tr;
  String get totalText => 'total'.tr;
  String get accountText => 'account'.tr;
  String get dealsText => 'deals'.tr;
  String get homeText => 'home'.tr;
  String get emptyText => 'cart_empty'.tr;
  String get startText => 'start_shopping'.tr;
  String get pleaseloginText => 'please_login'.tr;
  String get LoginText => 'Login'.tr;
  String get loginText => 'login'.tr;
  String get logyouraccountText => 'log_your_account'.tr;
  String get loginsubText => 'login_sub'.tr;
  String get phonenoText => 'phone_no'.tr;
  String get enternoText => 'enter_no'.tr;
  String get passwordText => 'password'.tr;
  String get enterpassText => 'enter_pass'.tr;
  String get forgotpassText => 'forgot_pass'.tr;
  String get rememberText => 'remember_me'.tr;
  String get dontaccText => 'dont_acc'.tr;
  String get createhereText => 'create_here'.tr;
  String get skipinText => 'skip_in'.tr;
  String get orderText => 'order_detail'.tr;
  String get totalamountText => 'total_amount'.tr;
  String get issuedText => 'issued'.tr;
  String get kmText => 'km'.tr;
  String get orderitemsText => 'ordered_item'.tr;
  String get prevText => 'prev'.tr;
  String get nextText => 'next'.tr;
  String get timeslotText => 'time_slot'.tr;
  String get datetimeText => 'date_time'.tr;
  String get todayText => 'today'.tr;
  String get tomorrowText => 'tomorrow'.tr;
  String get collectionText => 'collection'.tr;
  String get paymentText => 'payment'.tr;
  String get cashText => 'cash'.tr;
  String get availableText => 'available'.tr;
  String get cardText => 'card'.tr;
  String get confirmText => 'confirm'.tr;
  String get notificationText => 'notification'.tr;
  String get myOrdersText => 'my_orders'.tr;
  String get languageText => 'language'.tr;
  String get addAddressText => 'add_address'.tr;
  String get changeEmailText => 'change_email'.tr;
  String get editProfileText => 'edit_profile'.tr;
  String get changePasswordText => 'change_password'.tr;
  String get changeMobileText => 'change_mobile'.tr;
  String get logoutText => 'logout'.tr;
  String get summeryText => 'summery'.tr;

  String get changeText => 'payment_change'.tr;
  String get methodText => 'payment_method'.tr;
  String get timeText => 'delivery_time'.tr;
  String get dateText => 'delivery_date'.tr;
  String get collectiontimeText => 'collection_time'.tr;
  String get collectiondateText => 'collection_date'.tr;
  String get totalquantityText => 'total_quantity'.tr;
  String get servicesText => 'services'.tr;
  String get wemakeText => 'we_make'.tr;
  String get armangroceryText => 'arman_grocery'.tr;
  String get todoText => 'to_do'.tr;
  String get inprogressText => 'in_progress'.tr;
  String get completeText => 'complete'.tr;
  String get unassignedText => 'unassigned'.tr;
  String get addressText => 'address'.tr;
  String get youraddressText => 'your_address'.tr;
  String get submitText => 'submit'.tr;
  String get emailText=> 'email'.tr;
  String get youremailText => 'your_email'.tr;
  String get profileText => 'profile'.tr;
  String get yournameText => 'your_name'.tr;
  String get createnewpasswordText => 'create_new_password'.tr;
  String get yournewpasswordText => 'your_new_password'.tr;
  String get currentpasswordText => 'current_password'.tr;
  String get newpasswordText => 'new_password'.tr;
  String get confirmpassword => 'confirm_password'.tr;
  String get resetpassword => 'reset_password'.tr;
  String get changenumberText => 'change_number'.tr;
  String get yournumberText => 'your_number'.tr;
  String get sendanotpText => 'send_an_otp'.tr;
  String get sendotpText => 'send_otp'.tr;
  String get yourotpText => 'your_otp'.tr;
  String get verifyotpText => 'verify_otp'.tr;
  String get personaldetailsText => 'personal_details'.tr;
  String get agreetoText => 'agree_to'.tr;
  String get termsuseText => 'terms_use'.tr;
  String get andText => 'and'.tr;
  String get privacypolicyText => 'privacy_policy'.tr;
  String get thisappText => 'this_app'.tr;
  String get haveaccountText => 'have_account'.tr;
  String get loginhereText => 'login_here'.tr;
  String get registerText => 'register'.tr;
  String get verificationText => 'verification'.tr;
  String get enterOTPsentText => 'enter_OTP_sent_to'.tr;
  String get verifyText => 'verify'.tr;
  String get resendOTPText => 'resend_OTP'.tr;
  String get selectstoreText => 'select_store'.tr;
  String get choosestoreText => 'choose_store'.tr;
  String get nameText => 'name'.tr;
  String get forgotpasswordText => 'forgot_password'.tr;




}
