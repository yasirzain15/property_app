import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/payment_controller.dart';
import 'package:rent_pay/Core/Constants/colors.dart';

class PaymentPlans extends StatelessWidget {
  const PaymentPlans({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
    final plans = ["Day - \$1.00", "Monthly - \$20.00", "Yearly - \$240.00"];

    return Obx(
      () => Row(
        children: List.generate(plans.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.selectPlan(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: controller.selectedPlan.value == index
                      ? AppColors.primary
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    plans[index],
                    style: TextStyle(
                      color: controller.selectedPlan.value == index
                          ? AppColors.background
                          : AppColors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
