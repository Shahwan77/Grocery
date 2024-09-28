import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../presentation/Track & History/track_history.dart';
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
            height: 180.h,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.shade800,
                    Colors.red.shade400,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.white,
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

          SizedBox(height: 10.h,),
          // Container with 4 images
          Column(
            children: [
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/gro5.png', width: 30.w, height: 30.h),
                      Image.asset('assets/gro6.png', width: 30.w, height: 30.h),
                      Image.asset('assets/gro7.png', width: 30.w, height: 30.h),
                      Image.asset('assets/gro8.png', width: 30.w, height: 30.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                print('see all policies');
                              },
                              child: Text(
                                'see all policies',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
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
        padding:  EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          decoration: BoxDecoration(
            color: drawerController.selectedIndex.value == index
                ? Colors.red.shade200
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: drawerController.selectedIndex.value == index && index == 9
                  ? Colors.transparent
                  : Colors.transparent,
              width: 4.w,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(icon, color: Colors.red),
                title: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                  selectionColor: Colors.red,
                ),
                tileColor: drawerController.selectedIndex.value == index
                    ? Colors.green.shade100
                    : Colors.transparent,
                onTap: () {
                  drawerController.setSelectedIndex(index);

                  if (index == 3) {
                    Get.to(() => FavoritesPage());
                  } else if (index == 4) {
                    Get.to(() => TrackHistory());
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
