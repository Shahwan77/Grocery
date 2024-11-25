import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/presentation/bottomnav/page/bottom_nav.dart';
import 'package:grocery/presentation/shop_controller.dart';
import 'package:grocery/widgets/button/button.dart';
import '../data/apiClient/api.dart';

class SelectStorePage extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start, // Start from the top
              children: [
                SizedBox(height: 50.h), // Add spacing from the top
                Obx(() {
                  if (storeController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (storeController.shops.isEmpty) {
                    return Center(child: Text("No stores available"));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title and description
                      Text(
                        'Select a Store',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Choose a store to continue shopping',
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 20.h),

                      // GridView for store selection
                      GridView.builder(
                        shrinkWrap: true, // Prevents the grid from taking up all space
                        physics: NeverScrollableScrollPhysics(), // Disables grid scrolling
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.75, // Aspect ratio of grid items
                        ),
                        itemCount: storeController.shops.length,
                        itemBuilder: (context, index) {
                          var store = storeController.shops.values.toList()[index];

                          return GestureDetector(
                            onTap: () {
                              storeController.selectStore(store.id);
                              print('Selected Store ID: ${store.id}');
                            },
                            child: Obx(() {
                              // Determine if this store is selected
                              bool isSelected = store.id == storeController.selectedStoreId.value;

                              return Card(
                                color: isSelected ?  Color(0xFFEB1C23) : Colors.white, // Set blue if selected, else white
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                elevation: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Store image with error handling
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.r),
                                        topRight: Radius.circular(12.r),
                                      ),
                                      child: Image.network(
                                        '${Api.ImageUrl}/shops/${store.image}',
                                        width: double.infinity,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: double.infinity,
                                            height: 100.h,
                                            color: Colors.grey.shade300,
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.white,
                                              size: 40.sp,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Store name and address
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            store.name,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color:  isSelected ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            store.address ?? 'No address',
                                            style: TextStyle(
                                              color: isSelected ? Colors.white : Colors.grey.shade600,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  );
                }),

                // Button moved upwards
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    size: Size(300.w, 50.h),
                    color:  Color(0xFFEB1C23),
                    text: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ontap: () {
                      var selectedStoreId = storeController.box.read('selected_shop_id');
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
            ),
          ),
        ),
      ),
    );
  }
}
