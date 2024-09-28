import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fav_controller.dart';

class FavoritesPage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Obx(() {
        if (favoriteController.favoriteItems.isEmpty) {
          return Center(
            child: Text(
              'No items in favorites',
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: favoriteController.favoriteItems.length,
            itemBuilder: (context, index) {
              final item = favoriteController.favoriteItems[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ListTile(
                  leading: Image.network(
                    item['image']!,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    item['name']!,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Text(
                    item['price']!,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      favoriteController.toggleFavorite(
                        item['name']!,
                        item['price']!,
                        item['image']!,
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
