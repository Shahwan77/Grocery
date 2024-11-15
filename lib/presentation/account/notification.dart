import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Language Selection/language_controller.dart';
import '../order_details/my_orders_view.dart';
import 'notification_controller.dart';

class NotificationPage extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final WelcomeController languagecontroller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          leading:  IconButton(
            icon: Container(
                height: 22.h,width: 26.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r)
                ),
                child: Center(child: Icon(Icons.arrow_back_ios_rounded,color: Color(0xFFEB1C23),size: 20.sp,))),
            onPressed: () {
              Get.back();
            },
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFFEB1C23),
          title: Text(languagecontroller.notificationText, style: TextStyle(color: Colors.white)),      ),
        body: FutureBuilder(
          future: controller.fetchNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading notifications'));
            } else if (controller.notifications.isEmpty) {
              return Center(child: Text('No notifications available'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(Icons.notifications, color: Color(0xFFEB1C23)),
                        title: Text(notification.message),
                        subtitle: Text(notification.datetime),
                        onTap: () {
                          controller.markNotificationAsRead(notification.id);
                          if (notification.orderId != null) {
                            Get.to(() => OrderViewPage(orderId: notification.orderId!));
                          } else {
      
                          }
      
                        },
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
