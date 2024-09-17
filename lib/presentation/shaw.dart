import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/widgets/button/button.dart';

import 'hh.dart';

class BigBazr extends StatefulWidget {
  @override
  _BigBazrState createState() => _BigBazrState();
}

class _BigBazrState extends State<BigBazr> {
  int _selectedIndex = 0;
  bool _showTotalSales = true;
  bool _showPendingCoupon = false;
  bool _showRequest = false;

  List<int> firstTexts = [10, 9, 6, 7, 9, 6];
  List<int> secondTexts = [100, 500, 1000, 2000, 5000, 10000];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showContainer(String container) {
    setState(() {
      _showTotalSales = container == 'totalSales';
      _showPendingCoupon = container == 'pendingCoupon';
      _showRequest = container == 'request';
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Color(0xFF3a80a4),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 90.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Total Advertisement',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 54.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF567391),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 6.h),
                        Text(
                          'Approved',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '10',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    height: 54.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF567391),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 6.h),
                        Text(
                          'Pending',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Show Total Sales container
              if (_showTotalSales)
                Container(
                  height: 375.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          'Total Sales',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Color(0xFF800000),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.w,
                              mainAxisSpacing: 12.h,
                                  mainAxisExtent: 108
                            ),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              bool isHighlighted = (firstTexts[index] == 10 ||
                                  firstTexts[index] == 7);
                              Color containerColor = isHighlighted
                                  ? Colors.grey.shade300
                                  : Color(0xFF395da4);
                              TextStyle textStyle = TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900,
                                color: isHighlighted
                                    ? Color(0xFF3a80a4)
                                    : Colors.white,
                              );
                              return Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset('assets/doc.png',height: 40,width: 40,),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${firstTexts[index]}',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                              color: isHighlighted
                                                  ? Color(0xFF3a80a4)
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      '${secondTexts[index]}/-',
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 18.h),
                        Button(
                          size: Size(200.w, 36.h),
                          color: Color(0xFF005B82),
                          text: Text(
                            'Pending Coupon',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          ontap: () => _showContainer('pendingCoupon'),
                        ),
                        SizedBox(height: 18.h),
                        Button(
                          size: Size(200.w, 36.h),
                          color: Colors.green,
                          text: Text(
                            'Request',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                          ontap: () => _showContainer('request'),
                        ),
                      ],
                    ),
                  ),
                ),
              // Show Pending Coupon container
              if (_showPendingCoupon)
                Container(
                    height: 375.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 30.sp,
                                ),
                                onPressed: () {
                                  _showContainer('totalSales');
                                },
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60.w),
                                child: Text(
                                  'Pending Coupons',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                    color: Color(0xFF800000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8.w,
                                  mainAxisSpacing: 12.h,
                                  mainAxisExtent: 108
                              ),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                bool isHighlighted = (firstTexts[index] == 10 ||
                                    firstTexts[index] == 7);
                                Color containerColor = isHighlighted
                                    ? Colors.grey.shade300
                                    : Color(0xFF395da4);
                                TextStyle textStyle = TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w900,
                                  color: isHighlighted
                                      ? Color(0xFF3a80a4)
                                      : Colors.white,
                                );
                                return Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset('assets/doc.png',height: 40,width: 40,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${firstTexts[index]}',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                                color: isHighlighted
                                                    ? Color(0xFF3a80a4)
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Text(
                                        '${secondTexts[index]}/-',
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
              // Show Request container
              if (_showRequest)
                Container(
                    height: 375.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30.sp,
                                  ),
                                  onPressed: () {
                                    _showContainer('totalSales');
                                  },
                                ),

                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 60.w),
                                  child: Text(
                                    'Request Coupons',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      color: Color(0xFF800000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    TextStyle textStyle = TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    );
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // Ensures even spacing between items
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 2.h,
                                            ),
                                            width: 250
                                                .w, // Adjust the width according to your needs
                                            height: 38.h,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    '${secondTexts[index]}/-',
                                                    style: textStyle,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 80
                                                          .w, // You can adjust this width as necessary
                                                      height: 50.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'QTY',
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 15.sp),
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          5.5.h,
                                                                      horizontal:
                                                                          5.w),
                                                        ),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.sp),
                                                        textAlign:
                                                            TextAlign.center,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Container(
                                            width: 40.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF5B247A),
                                                    Color(0xFF2AA7C8),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.r)),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 24.sp,
                                              color: Colors.white,
                                            )), // Adjust the icon size if needed
                                      ],
                                    );
                                  },
                                )),
                          ],
                        ),
                      ),
                    )),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.r),
                  bottomLeft: Radius.circular(40.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, BIGBAZR',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/big.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 105.h, // Adjust this value to position the text correctly
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '13',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
