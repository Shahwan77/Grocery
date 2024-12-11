import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/data/apiClient/api.dart';

import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/models/register_model.dart';

class UserData {
  final box = GetStorage();

  Future<User?> fetchUser() async {
    final String? token = box.read('access_token');
    final response = await http.get(
      Uri.parse(Api.User),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = User.fromJson(data['user']); // Accessing the 'user' key
      box.write('id', user.id);
      box.write('name', user.name);
      return user;
    } else {
      print("Failed to fetch user data: ${response.statusCode}");
      return null;
    }
  }
}

// class MyAppstatata extends StatelessWidget {
//   final UserData userData = UserData();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('User Info')),
//       body: FutureBuilder<User?>(
//         future: userData.fetchUser(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final user = snapshot.data!;
//             return Center(
//               child: Text(
//                 'Name: ${user.name}', // Displaying the user's name
//                 style: TextStyle(fontSize: 20),
//               ),
//             );
//           } else {
//             return Center(child: Text('No user data found.'));
//           }
//         },
//       ),
//     );
//   }
// }
