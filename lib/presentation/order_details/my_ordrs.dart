import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/presentation/order_details/my_orders_view.dart';
import 'package:http/http.dart' as http;

import '../../data/apiClient/api.dart';
import '../../data/models/my_order_model.dart';
import '../Language Selection/language_controller.dart';
import 'my_order_controller.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WelcomeController languagecontroller = Get.put(WelcomeController());
    final MyOrderController myordercontroller = Get.put(MyOrderController());

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
        body: FutureBuilder<List<myOrder>>(
          future: myordercontroller.fetchOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }  else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                  child:
                      Text('No orders found.', style: TextStyle(fontSize: 16)));
            } else {
              final orders = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order items',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w500)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(OrderViewPage(orderId: order.orderId));
                            },
                            child: Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              elevation: 4,
                              child: GestureDetector(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Color(0xFFEB1C23),
                                    child: Icon(
                                      Icons.shopping_bag,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text('Order ID: ${order.orderId}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                      )),
                                  subtitle: Text('Status: ${order.status}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14.sp,
                                      )),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      print('object');
                                      Get.to(OrderViewPage(orderId: order.orderId));
                                    },
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 16)),
                                ),
                              ),
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
