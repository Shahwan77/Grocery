import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/apiClient/api.dart';

class CusCarousel extends StatelessWidget {
  const CusCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CusCarouselController carouselController = Get.put(CusCarouselController());

    return Column(
      children: [
        FutureBuilder<void>(
          future: carouselController.fetchPromotions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (carouselController.banners.isEmpty) {
              return const Center(child: Text('No promotions available.'));
            }

            return CarouselSlider(
              options: CarouselOptions(
                height: 150.h,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  carouselController.updateIndex(index);
                },
              ),
              items: carouselController.banners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${Api.ImageUrl}/promotions/$banner',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: 10.h), // Space between the carousel and the dots
        Obx(() {
          if (carouselController.banners.isEmpty) {
            return const SizedBox();
          }

          return AnimatedSmoothIndicator(
            activeIndex: carouselController.currentIndex.value,
            count: carouselController.banners.length,
            effect: ScrollingDotsEffect(
              activeDotColor: const Color(0xFFEB1C23),
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
  var banners = <String>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> fetchPromotions() async {
    final String? selectedShopId = GetStorage().read('selected_shop_id');
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://grocery-dev.greendomains.in/api/promotions?shop_id=$selectedShopId'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success']) {
          final promotionData = jsonData['data'] as List;
          banners.value = promotionData
              .map((promo) => promo['banner'])
              .cast<String>()
              .toList();
        } else {
          Get.snackbar('Error', 'Failed to fetch promotions');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
    } finally {
      isLoading(false);
    }
  }
}
