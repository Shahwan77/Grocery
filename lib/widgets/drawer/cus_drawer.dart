import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/home_screen/page/home_page.dart';

import '../../presentation/favorite/fav_page.dart';
import 'controller.dart';

class CusDrawer extends StatelessWidget {
  final CusDrawerController drawerController = Get.put(CusDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          Container(
            height: 189,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade800,
                    Colors.green.shade400,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          // Drawer Items
          DrawerItem(Icons.home_outlined, 'Home', 0),
          DrawerItem(Icons.notifications_outlined, 'Notification', 1),
          DrawerItem(Icons.shop, 'Shop info', 2),
          DrawerItem(Icons.favorite_border, 'Favorite', 3),
          DrawerItem(Icons.location_searching, 'Track & History', 4),
          DrawerItem(Icons.local_offer_outlined, 'Promotions', 5),
          DrawerItem(Icons.map_outlined, 'Leaflet', 6),
          DrawerItem(Icons.share_outlined, 'Share Application', 7),
          DrawerItem(Icons.newspaper, 'Return Policies', 8),
          DrawerItem(Icons.login_outlined, 'Logout', 9),

          // Container with 4 images
          Column(
            children: [
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/gro5.png', width: 30, height: 30),
                      Image.asset('assets/gro6.png', width: 30, height: 30),
                      Image.asset('assets/gro7.png', width: 30, height: 30),
                      Image.asset('assets/gro8.png', width: 30, height: 30),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10), // Add some space between the container and the text
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Terms and Conditions, Privacy\npolicy, Return policy, ",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                "see all policies",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget DrawerItem(IconData icon, String title, int index) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: drawerController.selectedIndex.value == index
                ? Colors.green.shade100
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: drawerController.selectedIndex.value == index && index == 9
                  ? Colors.red.shade800
                  : Colors.transparent,
              width: 4.0,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(icon, color: Colors.green.shade800),
                title: Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  selectionColor: Colors.green.shade800,
                ),
                tileColor: drawerController.selectedIndex.value == index
                    ? Colors.green.shade100
                    : Colors.transparent,
                onTap: () {
                  drawerController.setSelectedIndex(index);
                  if (index == 3) {
                    Get.to(() => FavoritesPage());  // Navigate to FavoritesPage
                  }
                  // Handle navigation or other logic
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
