import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Cart/cart_controller.dart';
import '../../Cart/cart_page.dart';
import '../../Promotions/promotions_page.dart';
import '../../Search/search_page.dart';
import '../../home_screen/page/home_page.dart';
import '../controller/bottomnav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    PromotionsPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.put(BottomNavController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      body: Obx(
            () => pages[bottomNavController.selectedIndex.value],
      ),
      bottomNavigationBar: Obx(
            () {
          final cartItemCount = cartController.uniqueItemCount;

          return BottomNavigationBar(
            currentIndex: bottomNavController.selectedIndex.value,
            onTap: (index) {
              bottomNavController.updateIndex(index);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildIcon('assets/home.svg', 0, bottomNavController),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/search.svg', 1, bottomNavController),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/offer.svg', 2, bottomNavController),
                label: 'Promotions',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildIcon('assets/cart.svg', 3, bottomNavController),
                    if (cartItemCount > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade800,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 18.w,
                            minHeight: 18.h,
                          ),
                          child: Center(
                            child: Text(
                              '$cartItemCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Cart',
              ),
            ],
            selectedItemColor: Colors.green.shade800,
            unselectedItemColor: Colors.green.shade800,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
          );
        },
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
        color: isSelected ? Colors.green.shade800 : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SvgPicture.asset(
        imagePath,
        width: 22.w,
        height: 22.h,
        color: isSelected ? Colors.white : Colors.green.shade800,
      ),
    );
  }
}
