// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
//
// import '../data/apiClient/api.dart';
// import '../data/models/category_model.dart';
//
//
// class userdatas {
//   final box = GetStorage();
//   //final String token = Details().Token;
//
//   Future<Category?> fetchUser() async {
//     final response = await http.get(
//       Uri.parse("${Api.BaseUrl}/api/product-categories"),
//       headers: {
//         "Authorization": "Bearer",
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final user = Category.fromJson(data);
//       box.write('id', user.id);
//       box.write('name', user.name);
//       // box.write('store_id', user.storeId);
//       return user;
//
//     } else {
//       print("Failed to fetch user data");
//       return null;
//     }
//   }
// }
//
// class Details {
//   // final box = GetStorage();
//
//   int Id = GetStorage().read('id') ?? 0;
//   String UserName = GetStorage().read('name') ?? '';
//   // int StoreId = GetStorage().read('store_id') ?? 0;
//   // String Token = GetStorage().read('authToken');
// }