import 'package:get/get.dart';
import 'package:rent_pay/Controller/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
  }
}
