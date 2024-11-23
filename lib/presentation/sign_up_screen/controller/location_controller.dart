import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocationController extends GetxController {
  var location = ''.obs; // Store location as a string.
  final storage = GetStorage(); // Instance of GetStorage.

  Future<bool> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      location.value = 'Location services are disabled.';
      return false;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        location.value = 'Location permission denied.';
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      location.value = 'Location permission permanently denied.';
      return false;
    }

    // Get the current location
    Position position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    location.value = '${position.latitude}, ${position.longitude}';

    // Store location in GetStorage
    storage.write('latitude', position.latitude);
    storage.write('longitude', position.longitude);

    return true;
  }

  // Method to retrieve stored location
  String? getStoredLocation() {
    final lat = storage.read<double>('latitude');
    final lon = storage.read<double>('longitude');
    return (lat != null && lon != null) ? '$lat, $lon' : null;
  }
}
