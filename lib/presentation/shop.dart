import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/shop_controller.dart';
import 'package:grocery/widgets/button/button.dart';


class SelectStorePage extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    String? selectedStoreId;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(() {
            if (storeController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (storeController.shops.isEmpty) {
              return Center(child: Text("No stores available"));
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dropdown for store selection
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    hint: Text("Select Store"),
                    icon: Icon(Icons.arrow_drop_down),
                    items: storeController.shops.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedStoreId = value;
                      storeController.selectStore(selectedStoreId!);

                      // Print selected store ID
                      print('Selected Store ID: $selectedStoreId');
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    size: Size(300.w, 40.h),
                    color: Colors.red,
                    text: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    ontap: () {
                      if (selectedStoreId != null) {
                        print('Selected Store ID: $selectedStoreId');
                        Get.offAll(() => CustomBottomNavBar());
                      } else {
                        Get.snackbar('Error', 'Please select a store');
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
