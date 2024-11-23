import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/account/notification.dart';
import '../../Cart/cart_controller.dart';
import '../../Cart/cart_page.dart';
import '../../Language Selection/language_controller.dart';
import '../../Promotions/promotions_page.dart';
import '../../Categories/categories_navbar.dart';
import '../../account/account.dart';
import '../../delas.dart';
import '../../home_screen/controller/home_controller.dart';
import '../../home_screen/page/home_page.dart';
import '../controller/bottomnav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<Widget> pages = [
    HomePage(),
    CategoriesNavbar(),
    DealsPage(),
    Account(),
    CartPage(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.put(BottomNavController());
    final CartController cartController = Get.put(CartController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    HomeController homeController = Get.put(HomeController());

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Obx(
              () => pages[bottomNavController.selectedIndex.value],
        ),
        bottomNavigationBar: Obx(
              () {
            final cartItemCount = cartController.isLoggedIn()
                ? int.tryParse(cartController.total_quantity.value) ?? 0
                : cartController.localCartItemCount;

            return BottomNavigationBar(
              currentIndex: bottomNavController.selectedIndex.value,
              onTap: (index) {
                bottomNavController.updateIndex(index);
                if (index == 0) {
                  homeController.fetchCategories();
                  GetStorage().write('selectedButton', 'grocery');
                  print('Selected Button: Grocery');
                }
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/home.svg', 0, bottomNavController),
                  label: languagecontroller.homeText,
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/categories.svg', 1, bottomNavController),
                  label: languagecontroller.categoriesText,
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/offer.svg', 2, bottomNavController),
                  label: languagecontroller.dealsText,
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/account.svg', 3, bottomNavController),
                  label: languagecontroller.accountText,
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _buildIcon('assets/cart3.svg', 4, bottomNavController),
                      if (cartItemCount > 0)
                        Positioned(
                          right: -4,
                          top: -4,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow.shade800,
                              border: Border.all(
                                color: Color(0xFFEB1C23),
                                width: 2.w,
                              ),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 18.w,
                              minHeight: 18.h,
                            ),
                            child: Center(
                              child: Text(
                                '$cartItemCount',
                                style: TextStyle(
                                  color: Color(0xFFEB1C23),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: languagecontroller.cartText,
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/notification.svg', 5, bottomNavController),
                  label: languagecontroller.notificationText,
                ),
              ],
              selectedItemColor: Color(0xFFEB1C23),
              unselectedItemColor: Colors.black,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedFontSize: 10.sp,
              unselectedFontSize: 10.sp,

            );
          },
        ),
      ),
    );
  }

  Widget _buildIcon(String imagePath, int index, BottomNavController controller) {
    bool isSelected = controller.selectedIndex.value == index;
    return Container(
      height: 36.h,
      width: 40.w,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFEB1C23) : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SvgPicture.asset(
        imagePath,
        width: 22.w,
        height: 22.h,
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}
