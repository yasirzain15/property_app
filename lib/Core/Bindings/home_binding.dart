import 'package:get/get.dart';
import 'package:rent_pay/Controller/bottom_nav_controller.dart';
import 'package:rent_pay/Core/Bindings/notifications_binding.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
    NotificationsBinding().dependencies(); // 👈 preload
  }
}
