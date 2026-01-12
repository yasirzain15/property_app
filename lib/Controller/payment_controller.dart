import 'package:get/get.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';

class PaymentController extends GetxController {
  var selectedMethod = 0.obs;
  var rememberMe = false.obs;
  var selectedPlan = 1.obs; // 0=Day, 1=Monthly, 2=Yearly

  void selectMethod(int index) {
    selectedMethod.value = index;
  }

  void toggleRemember(bool value) {
    rememberMe.value = value;
  }

  void selectPlan(int index) {
    selectedPlan.value = index;
  }

  void payNow() {
    // 🔗 API / Stripe / Razorpay later
    Get.toNamed(AppRoutes.paymentSuccess);
  }
}
