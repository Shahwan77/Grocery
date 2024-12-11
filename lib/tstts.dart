// import 'package:flutter/cupertino.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:grocery/data/apiClient/api.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:latlong2/latlong.dart';
//
// class AddressController extends GetxController {
//   var isLoading = false.obs;
//   var responseMessage = ''.obs;
//   final TextEditingController addressController = TextEditingController();
//
//   var currentLocation = LatLng(0, 0).obs;
//
//   Future<void> fetchCoordinates(String address) async {
//     if (address.isEmpty) return;
//     try {
//       isLoading.value = true;
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         currentLocation.value = LatLng(locations[0].latitude, locations[0].longitude);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch location: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> postAddress() async {
//     isLoading.value = true;
//     final String token = GetStorage().read('access_token');
//     try {
//       final response = await http.post(
//         Uri.parse("${Api.ApiUrl}/address"),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({"address": addressController.text}),
//       );
//
//       if (response.statusCode == 201) {
//         Get.back();
//         responseMessage.value = "Address updated successfully!";
//       } else {
//         responseMessage.value =
//         "Failed to post address: ${response.statusCode}";
//       }
//     } catch (e) {
//       responseMessage.value = "An error occurred: $e";
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:get/get.dart';
// import 'address_controller.dart';
//
// class AddressPage extends StatelessWidget {
//   final AddressController controller = Get.put(AddressController());
//   final MapController mapController = MapController(); // Updated for controlling the map
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         backgroundColor: const Color(0xFFEB1C23),
//         title: const Text(
//           'Address',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: controller.addressController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.location_on, color: Color(0xFFEB1C23)),
//                 labelText: 'Address',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFFEB1C23), width: 2),
//                 ),
//                 hintText: 'Enter your full address here',
//               ),
//             ),
//           ),
//           Obx(() => controller.isLoading.value
//               ? const Center(child: CircularProgressIndicator(color: Color(0xFFEB1C23)))
//               : ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFEB1C23),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             ),
//             onPressed: () async {
//               await controller.fetchCoordinates(controller.addressController.text);
//               mapController.move(controller.currentLocation.value, 15.0); // Update map position
//             },
//             child: const Text('Submit Address'),
//           )),
//           Expanded(
//             child: Obx(() {
//               return FlutterMap(
//                 mapController: mapController, // Use mapController for control
//                 options: MapOptions(
//                   initialCenter: controller.currentLocation.value, // Use initialCenter
//                   initialZoom: 15.0, // Use initialZoom
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     subdomains: ['a', 'b', 'c'],
//                   ),
//                   CurrentLocationLayer(), // Layer to show the user's current location
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         point: controller.currentLocation.value,
//                         width: 40,
//                         height: 40,
//                         child: Icon(
//                           Icons.location_pin,
//                           size: 40,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             }),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

