import 'package:get/get.dart';
import '../../Core/Services/api_service.dart';
import '../../Core/Storage/local_storage.dart';
import '../../Core/Routes/app_routes.dart';
import '../../Core/Constants/api_endpoints.dart';

class LogoutController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  RxBool isLoading = false.obs;

  Future<void> logout({
    required String name,
    required String nic,
    required String email,
    required String mobileNo,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final body = {
        "name": name,
        "nic": nic,
        "email": email,
        "mobile_no": mobileNo,
        "password": password,
      };

      final response = await _api.postRequest(ApiEndpoints.logout, body);

      if (response.statusCode == 200 && response.body['success'] == true) {
        // ✅ Clear token
        LocalStorage.clearToken();

        // ✅ Go to login screen
        Get.offAllNamed(AppRoutes.login);

        Get.snackbar("Success", "Logout Successful");
      } else {
        Get.snackbar("Error", response.body['message'] ?? "Logout failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
