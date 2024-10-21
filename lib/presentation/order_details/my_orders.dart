import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/apiClient/api.dart';

// Base Item class
class Item {
  final int productId;
  final String name;
  final String price;
  final String? image; // Nullable for laundry items
  final int quantity;

  Item({
    required this.productId,
    required this.name,
    required this.price,
    this.image,
    required this.quantity,
  });
}

// Grocery item class
class GroceryItem extends Item {
  GroceryItem({
    required int productId,
    required String name,
    required String price,
    String? image,
    required int quantity,
  }) : super(
    productId: productId,
    name: name,
    price: price,
    image: image,
    quantity: quantity,
  );

  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}

// Laundry item class
class LaundryItem extends Item {
  final List<String> services;

  LaundryItem({
    required int productId,
    required String name,
    required String price,
    String? image,
    required int quantity,
    required this.services,
  }) : super(
    productId: productId,
    name: name,
    price: price,
    image: image,
    quantity: quantity,
  );

  factory LaundryItem.fromJson(Map<String, dynamic> json) {
    return LaundryItem(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
      services: List<String>.from(json['services'] ?? []),
    );
  }
}

// Order class to hold order details
class Order {
  final List<Item> items;
  final String totalAmount;
  final int totalQuantity;
  final String? collectionDate;
  final String collectionTime;
  final String deliveryDate;
  final String deliveryTime;
  final String paymentMethod;
  final String? paymentChange;

  Order({
    required this.items,
    required this.totalAmount,
    required this.totalQuantity,
    this.collectionDate,
    required this.collectionTime,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.paymentMethod,
    this.paymentChange,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['data']['items'] as List;
    List<Item> itemsList;

    // Creating the item list based on the type of order
    itemsList = itemsJson.map((item) {
      if (json['data']['type'] == 'grocery') {
        return GroceryItem.fromJson(item);
      } else {
        return LaundryItem.fromJson(item);
      }
    }).toList();

    return Order(
      items: itemsList,
      totalAmount: json['data']['total_amount'],
      totalQuantity: json['data']['total_quantity'],
      collectionDate: json['data']['collection_date'],
      collectionTime: json['data']['collection_time'],
      deliveryDate: json['data']['delivery_date'],
      deliveryTime: json['data']['delivery_time'],
      paymentMethod: json['data']['payment_method'],
      paymentChange: json['data']['payment_change'],
    );
  }
}

// OrderPage widget
class OrderPage extends StatelessWidget {
  GetStorage box = GetStorage();

  Future<Order> fetchOrder() async {
    final String? token = box.read('access_token');
    final String? type = box.read('selectedButton');
    final response = await http.get(
      Uri.parse('https://grocery-dev.greendomains.in/api/order?type=$type'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        return Order.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load order data');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFFEB1C23),
      ),
      body: FutureBuilder<Order>(
        future: fetchOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 16, color: Colors.red)));
          } else if (snapshot.hasData && snapshot.data!.items.isEmpty) {
            return Center(child: Text('No items found in your order.', style: TextStyle(fontSize: 16)));
          } else {
            final order = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Section
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Amount: \$${order.totalAmount}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Total Quantity: ${order.totalQuantity}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          if (box.read('selectedButton') == 'laundry') ...[
                            Text('Collection Date: ${order.collectionDate}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 4),
                            Text('Collection Time: ${order.collectionTime}', style: TextStyle(fontSize: 16)),
                          ],
                          Text('Delivery Date: ${order.deliveryDate}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Delivery Time: ${order.deliveryTime}', style: TextStyle(fontSize: 16)),
                          Text('Payment Method: ${order.paymentMethod}', style: TextStyle(fontSize: 16)),
                          Text('Payment Change: ${order.paymentChange ?? "N/A"}', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),

                  // Divider for separation
                  SizedBox(height: 10),
                  Text('Order Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEB1C23),)),

                  // List of Order Items
                  // List of Order Items
                  Expanded(
                    child: ListView.builder(
                      itemCount: order.items.length,
                      itemBuilder: (context, index) {
                        final item = order.items[index];
                        final String? selectedType = box.read('selectedButton'); // Read selectedButton

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            leading: Image.network(
                              '${Api.ImageUrl}/products/${item.image}',
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.hide_image_outlined, size: 90.sp, color: Colors.grey),
                            ),
                            title: Text(item.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Common Price display
                                Text('Price: \$${double.tryParse(item.price) ?? 0.0}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),

                                // Conditionally show the services if the type is 'laundry' and the item is a LaundryItem
                                if (selectedType == 'laundry' && item is LaundryItem)
                                  Text('Services: ${item.services.join(', ')}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                              ],
                            ),
                            trailing: Text('Qty: ${item.quantity}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}
