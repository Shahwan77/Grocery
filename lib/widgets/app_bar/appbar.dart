import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/Promotions/promotions_page.dart';
import 'package:grocery/presentation/home_screen/controller/home_controller.dart';
import 'package:grocery/widgets/drawer/cus_drawer.dart';

import '../../Admin/to_do_controller.dart';
import '../../presentation/Cart/cart_controller.dart';
import '../../presentation/Language Selection/language_controller.dart';
import '../../presentation/Promotions/promotion_controller.dart';
import '../../presentation/Scanner/scanner_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;

  const CustomAppBar({
    Key? key,
    this.toolbarHeight = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    final CartController cartController = Get.put(CartController());
    final WelcomeController controller = Get.put(WelcomeController());
    // final PromotionController promotionController = Get.put(PromotionController());

    //final OrderController orderController = Get.put(OrderController());

    final box = GetStorage();


    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFEB1C23),
        statusBarIconBrightness: Brightness.light,
      ),
      surfaceTintColor: Colors.white,
      backgroundColor: Color(0xFFEB1C23),
      elevation: 0,
      toolbarHeight: toolbarHeight,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Grocery Container
              Obx(() => Container(
                height: ScreenUtil().screenWidth >600?78.h:64.h,
                width: 74.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: homeController.selectedIndex.value == 0
                      ? Colors.white54
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    homeController.fetchCategories();
                    box.write('selectedButton', 'grocery');
                    String selectedButton = box.read('selectedButton'); // Retrieve value from local storage
                    print('Selected Button: $selectedButton');
                    //orderController.fetchAdminOrderlist();// Print the value
                  },

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png', width: 40.w),
                      Text(
                        controller.groceryText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: homeController.selectedIndex.value == 0
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              // Laundry Container
              Obx(() => Container(
                height: ScreenUtil().screenWidth >600?78.h:64.h,
                width: 74.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: homeController.selectedIndex.value == 1
                      ? Colors.white54
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    homeController.fetchLaundry();
                    box.write('selectedButton', 'laundry');
                    String selectedButton = box.read('selectedButton'); // Retrieve value from local storage
                    print('Selected Button: $selectedButton');
                    //orderController.fetchAdminOrderlist();// Store value in local storage
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/laundry2.png', width: 40.w),
                      Text(
                        controller.laundryText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: homeController.selectedIndex.value == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              // Offers Container
              Obx(() => Container(
                height: ScreenUtil().screenWidth >600?78.h:64.h,
                width: 74.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: homeController.selectedIndex.value == 2
                      ? Colors.white54
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    homeController.selectedIndex.value = 2;
                    homeController.fetchPromotions();
                    box.write('selectedButton', 'promotion');
                    String selectedButton = box.read('selectedButton'); // Retrieve value from local storage
                    print('Selected Button: $selectedButton');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/offers2.png', width: 40.w),
                      Text(
                        controller.offersText,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: homeController.selectedIndex.value == 2
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              // AJ Container
              Obx(() => Container(
                height: ScreenUtil().screenWidth >600?78.h:64.h,
                width: 74.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: homeController.selectedIndex.value == 3
                      ? Colors.white54
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    homeController.selectedIndex.value = 3;
                    homeController.fetchAjProducts();
                    box.write('selectedButton', 'aj');
                    String selectedButton = box.read('selectedButton'); // Retrieve value from local storage
                    print('Selected Button: $selectedButton');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/aj.png', width: 70.w, height: 50),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                         controller.ajText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: homeController.selectedIndex.value == 3
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
