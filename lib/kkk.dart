import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/presentation/organic/organic_model.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A0353),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 16.h,
mainAxisExtent: 202
                ),
                itemCount: organicItems.length,
                itemBuilder: (context, index) {
                  final organicItem = organicItems[index];
                  return Column(
                    children: [
                      Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Image.asset(organicItem.imagePath,fit: BoxFit.contain,)
                      ),
                      SizedBox(height: 10.h,),
                      Text(organicItem.name,style: TextStyle(fontWeight: FontWeight.w600),)
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 60.h,)
          ],
        ),
      ),
    );
  }
}
