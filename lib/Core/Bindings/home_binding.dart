import 'package:get/get.dart';
import 'package:rent_pay/Controller/bottom_nav_controller.dart';
import 'package:rent_pay/Controller/notifications_controller.dart';
import 'package:rent_pay/Core/Bindings/installment_bindings.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Bottom navigation controller
    Get.put(BottomNavController(), permanent: true);

    // Installment feature (preloaded)
    InstallmentBindings().dependencies();

    // ✅ Notifications controller for BottomNav tab
    Get.put(NotificationsController(), permanent: true);
  }
}
