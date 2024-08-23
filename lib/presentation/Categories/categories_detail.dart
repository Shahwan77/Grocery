import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_screen/models/categories_model.dart';
import '../ice cream/ice_page.dart';
import '../organic/organic_page.dart';

class DetailPage extends StatelessWidget {
  final ItemModel item;

  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.name == 'FROZEN ICE CREAM') {
      return IceCreamPage();
    } else if (item.name == 'ORGANIC &\nHEALTHY FOOD') {
      return OrganicPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
          style:
          GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(item.imagePath), // Display the image
            SizedBox(height: 20.h),
            Text(
              item.name,
              style: GoogleFonts.roboto(
                  fontSize: 20.sp, fontWeight: FontWeight.w800),
            ),
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}
