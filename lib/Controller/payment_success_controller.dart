import 'package:get/get.dart';

class PaymentSuccessController extends GetxController {
  final transactionId = "4223456789323";
  final date = "1 January 2025";
  final type = "Credit Card";
  final plan = "Dedicated IP option";
  final amount = "\$09.99/month";
  final status = "Success";

  void backToHome() {
    Get.offAllNamed('/home');
  }
}
