import 'package:get/get.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import 'package:rent_pay/Utils/global_loader.dart';

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

  /// ✅ PAY NOW WITH GLOBAL LOADER
  Future<void> payNow() async {
    try {
      // 🔄 Show global loader
      GlobalLoader.show();

      // ⏳ Fake API delay (replace with real API later)
      await Future.delayed(const Duration(seconds: 2));

      // ✅ Navigate to payment success
      Get.toNamed(AppRoutes.paymentSuccess);
    } catch (e) {
      Get.snackbar('Error', 'Payment failed');
    } finally {
      // ❌ Hide global loader
      GlobalLoader.hide();
    }
  }
}
