import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Controller/notifications_controller.dart';
import 'package:rent_pay/Widgets/Notifications/fb_notification_tile.dart';
import 'package:rent_pay/Widgets/common_app_bar.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(
        title: "Notifications",
        actions: [
          TextButton(
            onPressed: controller.markAllRead,
            child: const Text(
              "Mark all read",
              style: TextStyle(color: AppColors.background),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          children: const [
            FbNotificationTile(
              icon: Icons.payment,
              iconBg: Colors.green,
              title: "Payment received.",
              description: "Your rent payment was successful.",
              time: "2 minutes ago",
              isUnread: true,
            ),
            FbNotificationTile(
              icon: Icons.home,
              iconBg: Colors.blue,
              title: "New property added.",
              description: "A new rental is available near you.",
              time: "1 hour ago",
              isUnread: true,
            ),
            Divider(),
            FbNotificationTile(
              icon: Icons.notifications,
              iconBg: Colors.orange,
              title: "Reminder.",
              description: "Your installment is due tomorrow.",
              time: "Yesterday",
            ),
          ],
        ),
      ),
    );
  }
}
