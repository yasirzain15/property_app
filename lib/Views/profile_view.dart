import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/global_loader_controller.dart';

import 'package:rent_pay/Core/Constants/app_assets.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Widgets/common_app_bar.dart';

import '../Controller/profile_controller.dart';
import '../Controller/update_profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  // ✅ From InitialBinding
  final ProfileController controller = Get.find<ProfileController>();
  final UpdateProfileController updateController =
      Get.find<UpdateProfileController>();
  final GlobalLoaderController loader = Get.find<GlobalLoaderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "My Profile", showBack: true),

      body: Stack(
        children: [
          // ================= MAIN UI =================
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ================= PROFILE IMAGE =================
                Obx(() {
                  final imagePath = controller.profileImage.value;

                  return GestureDetector(
                    onTap: controller.pickProfileImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.primary.withOpacity(0.3),
                      child: ClipOval(
                        child: imagePath.isNotEmpty
                            ? Image.file(
                                File(imagePath),
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppAssets.profile,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                _buildTextField(
                  "Name",
                  controller.nameController,
                  Icons.person,
                ),

                _buildTextField(
                  "Father / Husband Name",
                  controller.fatherNameController,
                  Icons.people,
                ),

                _buildTextField(
                  "Email",
                  controller.emailController,
                  Icons.email,
                ),

                _buildTextField(
                  "CNIC",
                  controller.cnicController,
                  Icons.credit_card,
                ),

                _buildTextField(
                  "Phone Number",
                  controller.phoneController,
                  Icons.phone,
                ),

                const SizedBox(height: 12),

                // ================= GENDER =================
                Obx(() {
                  final selectedGender = controller.gender.value;

                  return Row(
                    children: [
                      const Text(
                        "Gender:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 20),

                      _genderChip("Male", selectedGender),
                      const SizedBox(width: 10),
                      _genderChip("Female", selectedGender),
                    ],
                  );
                }),

                const SizedBox(height: 12),

                // ================= DOB =================
                _buildDateOfBirthField(context),

                const SizedBox(height: 20),

                // ================= ADDRESSES =================
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Customer Addresses",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      ...controller.addresses.map(
                        (address) => ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(address),
                        ),
                      ),

                      TextButton.icon(
                        onPressed: controller.addAddressDialog,
                        icon: const Icon(Icons.add, color: AppColors.primary),
                        label: const Text(
                          "Add Address",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 20),

                // ================= DOCUMENTS =================
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Customer Documents",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      ...controller.documents.map(
                        (file) => ListTile(
                          leading: const Icon(
                            Icons.insert_drive_file,
                            color: AppColors.primary,
                          ),
                          title: Text(file.split('/').last),
                        ),
                      ),

                      TextButton.icon(
                        onPressed: controller.pickDocumentFile,
                        icon: const Icon(Icons.upload_file),
                        label: const Text(
                          "Upload Document",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 30),

                // ================= BUTTONS ROW =================
                Row(
                  children: [
                    // ===== UPDATE =====
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.primary,
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            loader.show();

                            await updateController.updateProfile(
                              name: controller.nameController.text.trim(),
                              fatherName: controller.fatherNameController.text
                                  .trim(),
                              email: controller.emailController.text.trim(),
                              nic: controller.cnicController.text.trim(),
                              phone: controller.phoneController.text.trim(),
                              gender: controller.gender.value,
                              dob: controller.dobController.text.trim(),
                              addresses: controller.addresses.toList(),
                              profileImage: controller.profileImage.value,
                            );

                            loader.hide();
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // ===== CHANGE PASSWORD =====
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () {
                            // Get.to(() => ChangePasswordView());
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            "Change Password",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ================= ERROR MESSAGE =================
                Obx(() {
                  final error = updateController.errorMessage.value;
                  if (error.isEmpty) return const SizedBox.shrink();

                  return Text(error, style: const TextStyle(color: Colors.red));
                }),
              ],
            ),
          ),

          // ================= GLOBAL LOADER OVERLAY =================
          Obx(() {
            if (!loader.isLoading.value) return const SizedBox();

            return Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ================= TEXT FIELD =================
  Widget _buildTextField(
    String hint,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primary),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  // ================= GENDER CHIP =================
  Widget _genderChip(String value, String selectedGender) {
    return ChoiceChip(
      label: Text(
        value,
        style: TextStyle(
          color: selectedGender == value ? Colors.white : AppColors.primary,
        ),
      ),
      selected: selectedGender == value,
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.background,
      shape: StadiumBorder(side: BorderSide(color: AppColors.primary)),
      onSelected: (val) {
        if (val) controller.gender.value = value;
      },
    );
  }

  // ================= DOB =================
  Widget _buildDateOfBirthField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller.dobController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Date of Birth",
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: AppColors.primary,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate:
                DateTime.tryParse(controller.dobController.text) ??
                DateTime(1995),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (picked != null) {
            controller.dobController.text = picked
                .toIso8601String()
                .split('T')
                .first;
          }
        },
      ),
    );
  }
}
