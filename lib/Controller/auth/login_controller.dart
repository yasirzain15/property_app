import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Core/Constants/api_endpoints.dart';
import 'package:rent_pay/Core/Services/api_service.dart';
import 'package:rent_pay/Core/Storage/local_storage.dart';
import 'package:rent_pay/Models/auth/login_response_model.dart';
import 'package:rent_pay/Utils/global_loader.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final TextEditingController nicController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// Remove dashes for internal use if needed
  String get formattedCnic {
    String cnic = nicController.text.replaceAll('-', '');
    if (cnic.length != 14) return nicController.text; // fallback
    // Format as server expects
    return '${cnic.substring(0, 5)}-${cnic.substring(5, 13)}-${cnic.substring(13)}';
  }

  Future<void> login() async {
    final nic = formattedCnic;
    final password = passwordController.text.trim();

    if (nic.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "CNIC & Password are required");
      return;
    }

    GlobalLoader.show();

    final body = {"nic": nic, "password": password};

    try {
      final response = await _apiService.postRequest(ApiEndpoints.login, body);

      if (response.statusCode == 200 && response.body != null) {
        final model = LoginResponseModel.fromJson(response.body);

        if (model.success) {
          LocalStorage.saveToken(model.data.token);
          Get.snackbar("Success", model.message);
          Get.offAllNamed('/home');
        } else {
          Get.snackbar("Login Failed", model.message);
        }
      } else {
        Get.snackbar("Error", "Invalid server response");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      GlobalLoader.hide();
    }
  }

  @override
  void onClose() {
    nicController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
