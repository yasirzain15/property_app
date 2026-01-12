import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/payment_controller.dart';
import 'package:rent_pay/Core/Constants/colors.dart';

class PaymentMethodCard extends StatelessWidget {
  final int index;
  final String title;
  final String number;

  const PaymentMethodCard({
    super.key,
    required this.index,
    required this.title,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: controller.selectedMethod.value == index
                ? AppColors.primary
                : Colors.transparent,
          ),
        ),
        child: ListTile(
          leading: const Icon(Icons.credit_card, color: AppColors.black),
          title: Text(title, style: const TextStyle(color: AppColors.black)),
          subtitle: Text(number, style: TextStyle(color: Colors.grey.shade700)),
          trailing: const Icon(Icons.expand_more, color: AppColors.black),
          onTap: () => controller.selectMethod(index),
        ),
      ),
    );
  }
}
