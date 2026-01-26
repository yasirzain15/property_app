import 'package:get/get.dart';
import '../../Controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ProfileController(),
      permanent: true, // ✅ IMPORTANT
    );
  }
}
