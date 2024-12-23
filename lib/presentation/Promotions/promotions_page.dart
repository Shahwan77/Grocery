import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery/presentation/Promotions/promotion_product.dart';
import 'package:grocery/presentation/home_screen/controller/home_controller.dart';
import 'package:intl/intl.dart';

import '../../data/apiClient/api.dart';

class PromotionsPage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final now = DateTime.now();
  final dateFormatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.promotionsList.isEmpty) {
            return Center(child: Text('No promotions available'));
          } else {
            // Filter promotions based on the end date
            final activePromotions = controller.promotionsList.where((promotion) {
              try {
                final endDate = dateFormatter.parse(promotion.end);
                return endDate.isAfter(now);
              } catch (e) {
                print('Invalid date format for promotion: ${promotion.end}');
                return false; // Exclude promotions with invalid dates
              }
            }).toList();

            if (activePromotions.isEmpty) {
              return Center(child: Text('No active promotions'));
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: activePromotions.length,
              itemBuilder: (context, index) {
                final promotion = activePromotions[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => PromoProductsPage(promotionName: promotion.name));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Image.network(
                          '${Api.ImageUrl}/promotions/${promotion.banner}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ],
    );
  }
}
