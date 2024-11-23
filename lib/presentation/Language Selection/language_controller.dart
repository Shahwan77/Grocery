import 'dart:ui';

import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var selectedLanguage = 'English'.obs;

  void selectLanguage(String language) {
    selectedLanguage.value = language;

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



}
