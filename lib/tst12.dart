import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class UserService {
  final String apiUrl = 'https://grocery-dev.greendomains.in/api/user';
  final box = GetStorage();


  Future<void> fetchUserData() async {
    final String token = box.read('access_token');
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = data['user'];
      if (user != null) {
        storeUserData(user['name'], user['mobile_no'], user['id']);
      }
    } else {
      throw Exception('Failed to fetch user data');
    }
  }


  void storeUserData(String name, String mobileNo, int id) {
    final storage = GetStorage();
    print('Storing: Name: $name, Mobile: $mobileNo, ID: $id');
    storage.write('name', name);
    storage.write('mobile_no', mobileNo);
    storage.write('id', id);
  }

}

class Details {
  final storage = GetStorage();

  String name = '';
  String mobileNo = '';
  int id = 0;

  // Constructor to load data and print it
  Details() {
    name = storage.read('name') ?? 'No name';
    mobileNo = storage.read('mobile_no') ?? 'No mobile number';
    id = storage.read('id') ?? 0;

    printDetails();  // Call a method to print the details
  }

  // Method to print details
  void printDetails() {
    print('Name: $name, Mobile: $mobileNo, ID: $id');
  }
}
