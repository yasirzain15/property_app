import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../Core/Services/api_service.dart';
import '../Core/Constants/api_endpoints.dart';
import '../Models/profile_model.dart';
import '../Controller/global_loader_controller.dart';

class ProfileController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final GlobalLoaderController loader = Get.find<GlobalLoaderController>();

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
  void onInit() {
    super.onInit();
    print("🚀 ProfileController Ready");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProfile();
    });
  }

  // ================= FETCH PROFILE =================
  Future<void> fetchProfile() async {
    try {
      loader.show();
      print("🔹 Fetch Profile Start");

      final response = await _api.getRequest(ApiEndpoints.profile);

      print("📡 Response: ${response.body}");
      print("🔢 Status: ${response.statusCode}");

      if (response.statusCode == 200 && response.body['success'] == true) {
        final model = ProfileResponseModel.fromJson(response.body);
        profile.value = model.data;

        _fillProfile();
        print("✅ Profile Loaded");
      } else {
        errorMessage.value = "Failed to load profile";
      }
    } catch (e) {
      errorMessage.value = "Something went wrong";
      print("❌ ERROR: $e");
    } finally {
      loader.hide();
      print("🔹 Fetch Completed");
    }
  }

  // ================= FILL UI =================
  void _fillProfile() {
    final data = profile.value;
    if (data == null) return;

    print("📦 Filling UI...");

    nameController.text = data.name ?? '';
    fatherNameController.text = data.fOrHName ?? '';
    emailController.text = data.email ?? '';
    cnicController.text = data.nic ?? '';
    phoneController.text = data.mobileNo ?? '';
    dobController.text = data.dob ?? '';
    gender.value = data.gender ?? '';

    profileImage.value = data.profileImage ?? '';

    addresses.clear();
    documents.clear();

    if (data.customerAddresses != null) {
      for (var a in data.customerAddresses!) {
        if (a.address != null && a.address!.isNotEmpty) {
          addresses.add(a.address!);
        }
      }
    }

    if (data.customerDocuments != null) {
      for (var d in data.customerDocuments!) {
        if (d.filePath != null && d.filePath!.isNotEmpty) {
          documents.add(d.filePath!);
        }
      }
    }
  }

  // ================= PICK PROFILE IMAGE =================
  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      profileImage.value = file.path;
      print("🖼 Image Picked: ${file.path}");
    }
  }

  // ================= ADD ADDRESS =================
  void addAddressDialog() {
    final text = TextEditingController();

    Get.defaultDialog(
      title: "Add Address",
      content: TextField(
        controller: text,
        decoration: const InputDecoration(hintText: "Enter address"),
      ),
      textConfirm: "Add",
      textCancel: "Cancel",
      onConfirm: () {
        if (text.text.trim().isNotEmpty) {
          addresses.add(text.text.trim());
        }
        Get.back();
      },
    );
  }

  // ================= PICK DOCUMENT =================
  Future<void> pickDocumentFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      documents.add(result.files.single.path!);
      print("📄 Document Added: ${result.files.single.path}");
    }
  }
}
