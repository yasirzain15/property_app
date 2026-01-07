import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/installment_controller.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Constants/app_assets.dart';

class InstallmentCard extends StatelessWidget {
  final String propertyName;
  final String installmentAmount;
  final String dueDate;
  final int daysLeft;
  final String installmentNumber;
  final bool isUrgent;

  const InstallmentCard({
    super.key,
    required this.propertyName,
    required this.installmentAmount,
    required this.dueDate,
    required this.daysLeft,
    required this.installmentNumber,
    required this.isUrgent,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InstallmentController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                /// 🏠 PROPERTY IMAGE (ASSET)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    AppAssets.house1, // ✅ YOUR ASSET IMAGE
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 14),

                /// PROPERTY INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              propertyName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (isUrgent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Urgent",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Installment $installmentNumber",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Due: $dueDate ($daysLeft days left)",
                        style: TextStyle(
                          fontSize: 13,
                          color: isUrgent
                              ? Colors.red.shade700
                              : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 💰 BOTTOM ACTION BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  installmentAmount,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: controller.payNow,
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(color: AppColors.background),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
