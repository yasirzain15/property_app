import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/installment_controller.dart';
import 'package:rent_pay/Widgets/Installments/installment_card.dart';
import 'package:rent_pay/Widgets/Installments/notification_card.dart';
import 'package:rent_pay/Widgets/Installments/section_header.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_pay/Widgets/common_app_bar.dart';

class InstallmentView extends GetView<InstallmentController> {
  const InstallmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      /// 🔔 APP BAR (PROFILE STYLE)
      appBar: CommonAppBar(
        showBack: true,
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

      /// 📋 BODY
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 16),
          children: const [
            SectionHeader(title: "Upcoming Installments"),

            InstallmentCard(
              propertyName: "Springdale Heights",
              installmentAmount: "\$2,700",
              dueDate: "Jan 5, 2026",
              daysLeft: 12,
              installmentNumber: "3 of 12",
              isUrgent: true,
            ),

            SectionHeader(title: "Earlier"),

            NotificationCard(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: "Payment Successful",
              description: "Your installment was processed successfully.",
              time: "2 days ago",
            ),
          ],
        ),
      ),
    );
  }
}
