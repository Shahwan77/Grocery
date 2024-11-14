import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/apiClient/api.dart';
import '../../data/models/my_orderview_model.dart';
import '../Language Selection/language_controller.dart';
import '../replace/replace.dart';
import 'my_order_controller.dart';

class OrderViewPage extends StatelessWidget {
  final String orderId;

  OrderViewPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    final MyOrderController myordercontroller = Get.put(MyOrderController());
    final WelcomeController languagecontroller = Get.put(WelcomeController());

    return Scaffold(
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
          languagecontroller.orderText,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFFEB1C23),
      ),
      body: FutureBuilder<Orderview>(
        future: myordercontroller.fetchOrderview(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No orders found.'));
          } else if (snapshot.hasData) {
            final order = snapshot.data!.data;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order ID: ${order.orderId}",
                        style: TextStyle(fontSize: 18)),
                    Text("Total Amount: ${order.totalAmount}"),
                    Text("Delivery Date: ${order.deliveryDate ?? 'N/A'}"),
                    Text("Payment Method: ${order.paymentMethod}"),
                    Text("Payment Change: ${order.paymentChange ?? 'N/A'}"),
                    SizedBox(height: 16),
                    Text("Items:", style: TextStyle(fontSize: 18)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: order.items.length,
                      itemBuilder: (context, index) {
                        final item = order.items[index];
                        return Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.network(
                                  '${Api.ImageUrl}/products/${item.product.image}',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(item.product.name),
                                subtitle: order.type == "laundry"
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...item.services.map((service) {
                                      return Text("${service.service.name}");
                                    }).toList(),
                                  ],
                                )
                                    : Text("Price: \$${item.product.price}"),
                                trailing: Text(
                                  "Qty: ${item.quantity}",
                                  style: TextStyle(color: Color(0xFFEB1C23)),
                                ),
                              ),
                              // Show "View Replacements" button only if not laundry
                              if (order.type != "laundry" && item.replaceItems.isNotEmpty)
                                TextButton(
                                  onPressed: () {
                                    Get.to(
                                      MissingItemPage(
                                        itemId: item.id,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "View Replacements",
                                    style: TextStyle(color: Color(0xFFEB1C23)),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
