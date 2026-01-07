import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/installment_controller.dart';
import 'package:rent_pay/Widgets/Installments/installment_card.dart';
import 'package:rent_pay/Widgets/Installments/notification_card.dart';
import 'package:rent_pay/Widgets/Installments/section_header.dart';
import 'package:rent_pay/Core/Constants/colors.dart';

class InstallmentView extends GetView<InstallmentController> {
  const InstallmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      /// 🔔 APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
        actions: [
          TextButton(
            onPressed: controller.markAllRead,
            child: const Text(
              "Mark all read",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),

      /// 📋 BODY
      body: ListView(
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
    );
  }
}
