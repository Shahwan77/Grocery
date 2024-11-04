import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/presentation/replace/replace_controller.dart';
import 'package:grocery/widgets/button/button.dart';

import '../../data/apiClient/api.dart';
import '../../data/models/replace_model.dart';
import 'add_to_basket.dart';

class MissingItemPage extends StatelessWidget {
final int itemId;
MissingItemPage({required this.itemId});

  @override
  Widget build(BuildContext context) {
    final MissingItemController controller = Get.put(MissingItemController(itemId));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFEB1C23),
        title: Text(
          'Missing Item',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ReplaceOrder?>(
          future: controller.fetchOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load order: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No order details found.'));
            } else {
              final order = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.network(
                        '${Api.ImageUrl}/products/${order.product.image}',
                        height: 80,
                      ),
                      SizedBox(height: 8),
                      Text(
                        order.product.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'AED ${order.product.price}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'No quantity available out of ${order.quantity} ordered',
                          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select a substitute',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 10),

                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: order.replaceItems.length,
                      itemBuilder: (context, index) {
                        final replacementItem = order.replaceItems[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              ProductDetailPage(
                                id:order.id,
                                itemId: replacementItem.product.id,
                                itemName: replacementItem.product.name,
                                itemImage: '${Api.ImageUrl}/products/${replacementItem.product.image}',
                                itemPrice:double.parse(replacementItem.product.price) ?? 0.0, // Convert to double
                              ),
                            );
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  '${Api.ImageUrl}/products/${replacementItem.product.image}',
                                  height: 80,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  replacementItem.product.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'AED ${replacementItem.product.price}',
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: OutlinedButton(
                  //         onPressed: () {},
                  //         style: OutlinedButton.styleFrom(
                  //           side: BorderSide(color: Colors.grey),
                  //         ),
                  //         child: Text(
                  //           'No replacement',
                  //           style: TextStyle(color: Colors.black),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 16),
                  //     Expanded(
                  //       child: Button(
                  //         color: Color(0xFFEB1C23),
                  //         text: Text('Next', style: TextStyle(color: Colors.white)),
                  //         ontap: () {
                  //           Get.to(ProductDetailPage());
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
