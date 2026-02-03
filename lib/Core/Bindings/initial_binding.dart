import 'package:get/get.dart';
import 'package:rent_pay/Controller/update_profile_controller.dart';

import '../../Core/Services/api_service.dart';
import '../../Controller/auth/login_controller.dart';
import '../../Controller/auth/logout_controller.dart';
import '../../Controller/bottom_nav_controller.dart';
import '../../Controller/property_controller.dart';
import '../../Controller/profile_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    /// 🌐 API Service
    /// App-wide singleton
    Get.put<ApiService>(ApiService(), permanent: true);

    /// 🧭 Bottom Navigation Controller
    /// App-wide → survives navigation
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);

    /// 🏠 Property Controller
    Get.lazyPut<PropertyController>(() => PropertyController(), fenix: true);

    /// 👤 Profile Controller
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);

    /// 🔐 Login Controller
    /// Created only when LoginView is used
    Get.lazyPut<LoginController>(() => LoginController());

    /// 🚪 Logout Controller
    /// App-wide but lightweight
    Get.lazyPut<LogoutController>(() => LogoutController(), fenix: true);

    ///UPDATE PROFILE
    Get.lazyPut<UpdateProfileController>(
      () => UpdateProfileController(),
      fenix: true,
    );
  }
}
