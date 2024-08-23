import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here...',
                hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.green.shade800),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 15.w,
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}