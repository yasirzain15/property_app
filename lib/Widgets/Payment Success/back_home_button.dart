import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/payment_success_controller.dart';
import 'package:rent_pay/Core/Constants/colors.dart';

class BackHomeButton extends StatelessWidget {
  const BackHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentSuccessController>();

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: controller.backToHome,
        child: const Text(
          "Back to Home",
          style: TextStyle(
            color: AppColors.background,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
