import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';

class InstallmentController extends GetxController {
  void markAllRead() {
    // later: API / local logic
  }

  Future<void> payNow() async {
    // later: payment logic
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
