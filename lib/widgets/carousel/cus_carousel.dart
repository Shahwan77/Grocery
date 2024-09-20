import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CusCarousel extends StatelessWidget {
  const CusCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final CusCarouselController carouselController = Get.put(CusCarouselController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 150.h,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.9.w,
            onPageChanged: (index, reason) {
              carouselController.updateIndex(index);
            },
          ),
          items: [
            'assets/gro2.png',
            'assets/gro3.png',
            'assets/gro4.png',
          ].map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10.h), // Space between the carousel and the dots
        Obx(() {
          return AnimatedSmoothIndicator(
            activeIndex: carouselController.currentIndex.value,
            count: 3,
            effect: ScrollingDotsEffect(
              activeDotColor: Colors.green.shade800,
              dotColor: Colors.grey.shade200,
              dotHeight: 5.h,
              dotWidth: 20.w,
              spacing: 8.w,
            ),
            onDotClicked: (index) {
              carouselController.updateIndex(index);
            },
          );
        }),
      ],
    );
  }
}

class CusCarouselController extends GetxController {
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
