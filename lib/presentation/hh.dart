import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _locationMessage = "Getting current location...";

  // Function to get current location
  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    bool _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      setState(() {
        _locationMessage = "Location service is not enabled";
      });
      return;
    }

    // Check for location permission
    LocationPermission _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted == LocationPermission.denied) {
      // Request permission if not granted
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted != LocationPermission.whileInUse &&
          _permissionGranted != LocationPermission.always) {
        setState(() {
          _locationMessage = "Location permission denied";
        });
        return;
      }
    }

    // Get the current position
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _locationMessage =
      "Lat: ${_position.latitude}, Long: ${_position.longitude}";
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();  // Get location as soon as the page is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Location"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _locationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getCurrentLocation,
                child: Text("Get Current Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
