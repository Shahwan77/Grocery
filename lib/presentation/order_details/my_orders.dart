import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/apiClient/api.dart';
import '../Language Selection/language_controller.dart';

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
      Uri.parse('https://grocery-dev.greendomains.in/api/orders?shop_id=1&type=$type'),
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
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Container(
              height: 22.h,
              width: 26.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xFFEB1C23),
                  size: 20.sp,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            languagecontroller.myOrdersText,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Color(0xFFEB1C23),
        ),
        body: FutureBuilder<Order>(
          future: fetchOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}',
                      style: TextStyle(fontSize: 16, color: Colors.red)));
            } else if (snapshot.hasData && snapshot.data!.items.isEmpty) {
              return Center(
                  child: Text('No items found in your order.',
                      style: TextStyle(fontSize: 16)));
            } else {
              final order = snapshot.data!;
              return SingleChildScrollView(
                // Add this line
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Summary Section
                      Card(
                        color: Colors.white,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                languagecontroller.summeryText,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFEB1C23)),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(languagecontroller.totalamountText ,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700)),
                                  Text('\$${order.totalAmount}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(languagecontroller.totalquantityText,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700)),
                                  Text('${order.totalQuantity}',
                                      style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                              if (box.read('selectedButton') == 'laundry') ...[
                                SizedBox(height: 8.h),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(languagecontroller.collectiondateText,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700)),
                                    Text('${order.collectionDate}',
                                        style: TextStyle(fontSize: 16.sp)),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(languagecontroller.collectiontimeText,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700)),
                                    Text('${order.collectionTime}',
                                        style: TextStyle(fontSize: 16.sp)),
                                  ],
                                ),
                              ],
                              SizedBox(height: 8.h),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(languagecontroller.dateText,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700)),
                                  Text('${order.deliveryDate}',
                                      style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(languagecontroller.timeText,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700)),
                                  Text('${order.deliveryTime}',
                                      style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(languagecontroller.methodText,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700)),
                                  Text('${order.paymentMethod}',
                                      style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(languagecontroller.changeText,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700)),
                                  Text('${order.paymentChange ?? "N/A"}',
                                      style: TextStyle(fontSize: 16.sp)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        languagecontroller.orderitemsText,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEB1C23)),
                      ),

                      // List of order items
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: order.items.length,
                        itemBuilder: (context, index) {
                          final item = order.items[index];
                          final String? selectedType = box.read('selectedButton');

                          return Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: Image.network(
                                '${Api.ImageUrl}/products/${item.image}',
                                width: 80.w,
                                height: 80.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.hide_image_outlined,
                                        size: 90.sp, color: Colors.grey),
                              ),
                              title: Text(item.name,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // if (selectedType == 'grocery' &&
                                  //     item is GroceryItem)// Common Price display
                                  Text(
                                      'Price: \$${double.tryParse(item.price) ?? 0.0}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey[700])),

                                  // Conditionally show the services if the type is 'laundry' and the item is a LaundryItem
                                  if (selectedType == 'laundry' &&
                                      item is LaundryItem)
                                    Text('Services: ${item.services.join(', ')}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700])),
                                ],
                              ),
                              trailing: Text('Qty: ${item.quantity}',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
