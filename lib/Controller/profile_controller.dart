import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Core/Services/api_service.dart';
import '../../Core/Constants/api_endpoints.dart';
import '../../Models/profile_model.dart';
import '../../Utils/global_loader.dart';

class ProfileController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  Rx<ProfileData?> profile = Rx<ProfileData?>(null);
  RxString errorMessage = ''.obs;

  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final emailController = TextEditingController();
  final cnicController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  RxString gender = ''.obs;
  RxString profileImage = ''.obs;

  RxList<String> addresses = <String>[].obs;
  RxList<String> documents = <String>[].obs;

  @override
  void onReady() {
    super.onReady();
    print("🚀 ProfileController Ready");
    fetchProfile();
  }

  // ===================== FETCH PROFILE =====================
  Future<void> fetchProfile() async {
    print("🔹 Fetch Profile Start");

    try {
      GlobalLoader.show();
      errorMessage.value = '';

      final response = await _api.getRequest(ApiEndpoints.profile);

      print("📡 Response: ${response.body}");
      print("🔢 Status: ${response.statusCode}");

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = ProfileResponseModel.fromJson(response.body);
        profile.value = model.data;

        print("✅ Profile Loaded");

        _fillProfileData(); // ✅ SAFE NOW
      } else {
        errorMessage.value =
            response.body['message'] ?? "Failed to load profile";
        print("❌ API Failed");
      }
    } catch (e) {
      errorMessage.value = "Something went wrong";
      print("❌ Error: $e");
    } finally {
      GlobalLoader.hide();
      print("🔹 Fetch Completed");
    }
  }

  // ===================== FILL DATA =====================
  void _fillProfileData() {
    if (profile.value == null) return;

    final data = profile.value!;
    print("📦 Filling UI...");

    nameController.text = data.name ?? '';
    fatherNameController.text = data.fOrHName ?? '';
    emailController.text = data.email ?? '';
    cnicController.text = data.nic ?? '';
    phoneController.text = data.mobileNo ?? '';
    dobController.text = data.dob ?? '';
    gender.value = data.gender ?? '';

    addresses.assignAll(
      data.customerAddresses?.map((e) => e.address ?? '').toList() ?? [],
    );

    documents.assignAll(
      data.customerDocuments?.map((e) => e.filePath ?? '').toList() ?? [],
    );

    print("🏠 Addresses: ${addresses.length}");
    print("📄 Documents: ${documents.length}");
  }

  // ===================== IMAGE PICK =====================
  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      profileImage.value = file.path;
      print("🖼 Image Selected");
    }
  }

  // ===================== ADD ADDRESS =====================
  void addAddressDialog() {
    final addressController = TextEditingController();

    Get.defaultDialog(
      title: "Add Address",
      content: TextField(controller: addressController),
      textConfirm: "Add",
      onConfirm: () {
        if (addressController.text.isNotEmpty) {
          addresses.add(addressController.text);
          print("🏠 Address Added");
        }
        Get.back();
      },
    );
  }

  // ===================== PICK DOCUMENT =====================
  Future<void> pickDocumentFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );

    if (result != null) {
      documents.add(result.files.single.path!);
      print("📄 Document Added");
    }
  }

  // ===================== UPDATE PROFILE =====================
  Future<void> updateProfile() async {
    try {
      GlobalLoader.show();

      final body = {
        "name": nameController.text.trim(),
        "f_or_h_name": fatherNameController.text.trim(),
        "email": emailController.text.trim(),
        "nic": cnicController.text.trim(),
        "mobile_no": phoneController.text.trim(),
        "gender": gender.value,
        "dob": dobController.text.trim(),
        "addresses": addresses.toList(),
      };

      print("📦 Update Body: $body");

      Get.snackbar("Success", "Profile updated");
      print("✅ Update Done");
    } catch (e) {
      print("❌ Update Error: $e");
      Get.snackbar("Error", "Update Failed");
    } finally {
      GlobalLoader.hide();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    fatherNameController.dispose();
    emailController.dispose();
    cnicController.dispose();
    phoneController.dispose();
    dobController.dispose();
    print("🧹 Controller Closed");
    super.onClose();
  }
}
