import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import '../../../widgets/button/button.dart';
import '../../Language Selection/language_controller.dart';
import 'address_controller.dart';

class AddressPage extends StatelessWidget {
  final bool changeaddress;
  AddressPage({super.key, required this.changeaddress});
  final AddressController controller = Get.put(AddressController());
  final MapController mapController = MapController();
  final WelcomeController languagecontroller = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getCurrentLocation();
      mapController.move(controller.currentLocation.value, 15.0); // Move map to current location
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFEB1C23),
        leading: IconButton(
          icon: Container(
              height: 22.h,
              width: 26.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r)),
              child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xFFEB1C23),
                    size: 20.sp,
                  ))),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          languagecontroller.addressText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controller.addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on, color: Color(0xFFEB1C23)),
                    labelText: 'Address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFFEB1C23), width: 2),
                    ),
                    hintText: 'Enter your full address here',
                  ),
                ),
              ),
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFEB1C23)))
                  : Button(
                color: Color(0xFFEB1C23),
                ontap: () async {
                  await controller.fetchCoordinates(controller.addressController.text);
                  mapController.move(controller.currentLocation.value, 15.0);
                },
                text: Text('Search Address', style: TextStyle(color: Colors.white)),
              )),
              SizedBox(height: 10.h),
              SizedBox(
                height: 350.h,
                child: Obx(() {
                  return FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: controller.currentLocation.value, // Use initialCenter
                      initialZoom: 15.0, // Use initialZoom
                      onTap: (tapPosition, point) async {
                        controller.currentLocation.value = point;
                        await controller.reverseGeocode(point);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                        subdomains: ['0', '1', '2', '3'],
                      ),

                      CurrentLocationLayer(),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: controller.currentLocation.value,
                            width: 40.w,
                            height: 40.h,
                            child:  Icon(
                              Icons.location_pin,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              // Display Latitude and Longitude
              Obx(() {
                return Text(
                  'Latitude: ${controller.currentLocation.value.latitude}, '
                      'Longitude: ${controller.currentLocation.value.longitude}',
                  style: TextStyle(fontSize: 10.sp, color: Colors.black),
                );
              }),
              SizedBox(height: 10.h,),
              Button(
                color: Color(0xFFEB1C23),
                ontap: () async {
                  await controller.postAddress(changeaddress: changeaddress);
                },
                text: Text('Submit Address', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
