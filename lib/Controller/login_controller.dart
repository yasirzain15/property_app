import 'package:get/get.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import 'package:rent_pay/Utils/global_loader.dart';

class LoginController extends GetxController {
  /// 🔐 Login method
  Future<void> login() async {
    /// 🌍 Show global loader
    GlobalLoader.show();

    try {
      // ⏳ Fake API delay (replace later with real API)
      await Future.delayed(const Duration(seconds: 2));

      // ✅ Navigate to Home
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      /// 🌍 Hide global loader
      GlobalLoader.hide();
    }
  }
}
