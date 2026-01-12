import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/payment_controller.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Widgets/Payment/payment_method_card.dart';
import 'package:rent_pay/Widgets/Payment/payment_input_field.dart';
import 'package:rent_pay/Widgets/Payment/payment_plans.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: const BackButton(color: AppColors.black),
          title: const Text(
            "Payment",
            style: TextStyle(color: AppColors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a payment method",
                style: TextStyle(color: AppColors.black),
              ),
              const SizedBox(height: 12),

              PaymentMethodCard(
                index: 0,
                title: "Visa",
                number: "**** **** **** 4321",
              ),
              PaymentMethodCard(
                index: 1,
                title: "Mastercard",
                number: "**** **** **** 4321",
              ),

              const SizedBox(height: 24),
              const PaymentInputField(
                label: "Name on Card",
                hint: "Mastercard",
              ),
              const PaymentInputField(
                label: "Card Number",
                hint: "**** **** **** 4321",
              ),

              Row(
                children: const [
                  Expanded(
                    child: PaymentInputField(label: "CVV", hint: "000"),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: PaymentInputField(
                      label: "Expiration Date",
                      hint: "10/30",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Obx(
                () => CheckboxListTile(
                  value: controller.rememberMe.value,
                  onChanged: (v) => controller.toggleRemember(v!),
                  title: const Text(
                    "Remember me",
                    style: TextStyle(color: AppColors.primary),
                  ),
                  activeColor: AppColors.primary,
                  checkColor: AppColors.background,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),

              const SizedBox(height: 16),
              const PaymentPlans(),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: controller.payNow,
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
