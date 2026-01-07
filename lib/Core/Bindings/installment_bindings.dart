import 'package:get/get.dart';
import 'package:rent_pay/Controller/installment_controller.dart';

class InstallmentBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<InstallmentController>(
      InstallmentController(),
      permanent: true, // 👈 IMPORTANT
    );
  }
}
