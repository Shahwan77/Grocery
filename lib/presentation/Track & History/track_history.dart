import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class TrackHistory extends StatelessWidget {
  const TrackHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Track & History',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          backgroundColor: Colors.green.shade800,
        ),
        body: Column(
          children: [
            Container(
              height: 50.h,
              color: Colors.white,
              child:TabBar(
                indicatorColor: Colors.green,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'Track',),
                  Tab(text: 'History'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Track Tab Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Lottie.asset('assets/Animation - 1724233631425.json',),
                      SizedBox(height: 20.h),
                      Text(
                        'Tracking Not Available',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  // History Tab Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Lottie.asset('assets/Animation - 1724233631425.json'),
                      SizedBox(height: 20.h),
                      Text(
                        'No History Available',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
