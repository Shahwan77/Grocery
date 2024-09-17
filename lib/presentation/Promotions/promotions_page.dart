import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery/presentation/organic/organic_model.dart';

class PromotionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Promotions',
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () => _navigateToPage(index),
              child: Container(
                  height: 180.h,
                  width: 280.w,
                  child: Image.asset(
                    promo[index],
                    fit: BoxFit.fill,
                  )),
            ),
          );
        },
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Promotion 1',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Promotion 2',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
          title: Text('Promotion 3',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}

void _navigateToPage(int index) {
  switch (index) {
    case 0:
      Get.to(() => PageOne());
    // break;
    case 1:
      Get.to(() => PageTwo());
    // break;
    case 2:
      Get.to(() => PageThree());
    //break;
    // default:
    //   break;
  }
}
