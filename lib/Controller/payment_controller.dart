import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';

class PaymentController extends GetxController {
  var selectedMethod = 0.obs;
  var selectedPlan = 0.obs;
  var rememberMe = false.obs;

  void selectMethod(int index) {
    selectedMethod.value = index;
  }

  void selectPlan(int index) {
    selectedPlan.value = index;
  }

  void toggleRemember(bool value) {
    rememberMe.value = value;
  }

  /// ✅ PAY NOW WITH LOADING
  void payNow() async {
    // 🔄 Show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      barrierDismissible: false,
    );

    // ⏳ Fake delay (later API)
    await Future.delayed(const Duration(seconds: 2));

    // ❌ Close loading
    Get.back();

    // ✅ Go to success screen
    Get.toNamed(AppRoutes.paymentSuccess);
  }
}
