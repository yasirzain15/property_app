import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_pay/Utils/global_loader.dart';

class ProfileController extends GetxController {
  // Reactive variables
  var profileImage = ''.obs;
  var gender = ''.obs;

  // Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cnicController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  /// Pick profile image
  Future<void> pickProfileImage() async {
    try {
      GlobalLoader.show(); // 🔹 show loader
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        profileImage.value = pickedFile.path;
      }
    } finally {
      GlobalLoader.hide(); // 🔹 hide loader
    }
  }

  /// Update profile (future API call)
  Future<void> updateProfile() async {
    // Validate required fields
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    try {
      GlobalLoader.show(); // 🔹 show loader

      // ⏳ simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Future: send API request here
      Get.snackbar('Success', 'Profile updated successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      GlobalLoader.hide(); // 🔹 hide loader
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    emailController.dispose();
    cnicController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
