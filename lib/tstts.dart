// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'cart_controller.dart'; // Make sure to import your CartController
//
// class CartPage extends StatelessWidget {
//   final CartController cartController = Get.put(CartController());
//
//   @override
//   Widget build(BuildContext context) {
//     final token = GetStorage().read('access_token'); // Get the token from storage
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: FutureBuilder<void>(
//         future: cartController.fetchCartItems(token), // Call the fetch method
//         builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return Obx(() {
//               // Use Obx to reactively update the UI with fetched items
//               if (cartController.fetcedcartItems.isEmpty) {
//                 return Center(child: Text('No items in the cart.'));
//               }
//
//               return ListView.builder(
//                 itemCount: cartController.fetcedcartItems.length,
//                 itemBuilder: (context, index) {
//                   final item = cartController.fetcedcartItems[index];
//                   return ListTile(
//                     leading: Image.network(item['image']), // Display item image
//                     title: Text(item['name']),
//                     subtitle: Text('Price: ${item['price']} x ${item['quantity']}'),
//                   );
//                 },
//               );
//             });
//           }
//         },
//       ),
//     );
//   }
// }
