import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/data/apiClient/api.dart';
import 'package:grocery/presentation/order_details/order_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class AddressController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;
  final TextEditingController addressController = TextEditingController();
  var currentLocation = LatLng(0, 0).obs;

  Future<void> fetchCoordinates(String address) async {
    if (address.isEmpty) return;
    try {
      isLoading.value = true;
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        currentLocation.value = LatLng(locations[0].latitude, locations[0].longitude);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch location: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLocation.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      // Handle error (e.g., permission denied)
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> reverseGeocode(LatLng coordinates) async {
    try {
      isLoading.value = true;
      List<Placemark> placemarks =
      await placemarkFromCoordinates(coordinates.latitude, coordinates.longitude);
      if (placemarks.isNotEmpty) {
        addressController.text =
        '${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].country}';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch address: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postAddress({bool changeaddress = false}) async {
    isLoading.value = true;
    final String token = GetStorage().read('access_token');
    final Map<String, dynamic> requestBody = {
      "address": addressController.text,
      "latitude":currentLocation.value.latitude,
      "longitude": currentLocation.value.longitude,
    };
    try {
      print("Request Body: ${jsonEncode(requestBody)}");
      final response = await http.post(
        Uri.parse("${Api.ApiUrl}/address"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "address": addressController.text,
          "latitude":currentLocation.value.latitude,
          "longitude": currentLocation.value.longitude,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("Response Body: ${response.body}");
        changeaddress
        ? Get.off(OrderDetails())
        : Get.back();
        // Get.replace(() => OrderDetails());
        // Get.back(result: true);

        responseMessage.value = "Address updated successfully!";

        if (responseData['is_delivery'] == false) {
          showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Delivery Unavailable",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
              content: Text(
                "Sorry, Your location is outside of Al Reem area. So delivery not available in your location.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("OK",style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          );
        }
      } else {
        responseMessage.value =
        "Failed to post address: ${response.statusCode}";
        print("Failed to post address: ${response.statusCode}");
      }
    } catch (e) {
      responseMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
