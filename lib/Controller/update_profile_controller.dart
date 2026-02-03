import 'package:get/get.dart';
import 'package:rent_pay/Models/update_profile_model.dart';

import '../Core/Services/api_service.dart';
import '../Core/Constants/api_endpoints.dart';
import '../Utils/global_loader.dart';

class UpdateProfileController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  /// Update profile method
  Future<void> updateProfile({
    required String name,
    required String fatherName,
    required String email,
    required String nic,
    required String phone,
    required String gender,
    required String dob,
    required List<String> addresses,
    String? profileImage, // new optional parameter
  }) async {
    try {
      GlobalLoader.show();
      errorMessage.value = '';

      // Prepare request body
      final body = {
        "name": name,
        "f_or_h_name": fatherName,
        "email": email,
        "nic": nic,
        "mobile_no": phone, // ensure this is included
        "gender": gender,
        "dob": dob,
        "addresses": addresses, // your existing addresses
        "profile_image": profileImage ?? '', // send profile image if exists
        "customer_addresses": addresses, // explicitly send addresses
      };

      print("📦 UPDATE PROFILE BODY: $body");

      // Make API call
      final response = await _api.postRequest(ApiEndpoints.updateProfile, body);

      print("📡 UPDATE RESPONSE: ${response.body}");

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = UpdateProfileResponse.fromJson(response.body);

        Get.snackbar("Success", model.message);
        print("✅ Profile Updated");
      } else {
        // Handle backend errors
        final backendError =
            response.body['errors'] ?? response.body['message'];
        errorMessage.value = backendError.toString();
        Get.snackbar("Update Failed", backendError.toString());
        print("❌ Update Failed: $backendError");
      }
    } catch (e) {
      errorMessage.value = "Something went wrong";
      print("❌ UPDATE ERROR: $e");
    } finally {
      GlobalLoader.hide();
    }
  }
}
