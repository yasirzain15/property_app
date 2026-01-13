import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rent_pay/Utils/global_loader.dart';

import '../Core/Constants/colors.dart';
import '../Controller/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: AppColors.background),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: AppColors.background, // 👈 Back button color
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// 👤 PROFILE IMAGE
              Obx(
                () => GestureDetector(
                  onTap: controller.pickProfileImage,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.50),
                    radius: 60,
                    backgroundImage: controller.profileImage.value.isNotEmpty
                        ? FileImage(File(controller.profileImage.value))
                        : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🧾 FIELDS WITH ICONS
              _buildTextField(
                hint: "Name",
                controller: controller.nameController,
                icon: Icons.person,
              ),
              _buildTextField(
                hint: "Email",
                controller: controller.emailController,
                icon: Icons.email,
              ),
              _buildTextField(
                hint: "CNIC",
                controller: controller.cnicController,
                icon: Icons.credit_card,
              ),
              _buildTextField(
                hint: "Phone Number",
                controller: controller.phoneController,
                icon: Icons.phone,
              ),

              const SizedBox(height: 10),

              /// 🚻 GENDER
              _buildGenderSelector(),

              /// 📅 DOB
              _buildDateOfBirthField(context),

              const SizedBox(height: 30),

              /// 🔘 UPDATE BUTTON
              ElevatedButton(
                onPressed: () async {
                  /// 🌍 Show global loader
                  GlobalLoader.show();

                  try {
                    // ⏳ simulate API call or actual update
                    await Future.delayed(const Duration(seconds: 2));
                    await controller.updateProfile(); // call your update logic
                  } finally {
                    /// 🌍 Hide global loader
                    GlobalLoader.hide();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(color: AppColors.background),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== TEXT FIELD =====================
  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primary),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
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
      ),
    );
  }

  // ===================== GENDER =====================
  Widget _buildGenderSelector() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const Text(
              "Gender:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 20),

            ChoiceChip(
              label: Text(
                "Male",
                style: TextStyle(
                  color: controller.gender.value == "Male"
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              selected: controller.gender.value == "Male",
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.background,
              onSelected: (val) {
                if (val) controller.gender.value = "Male";
              },
            ),

            const SizedBox(width: 10),

            ChoiceChip(
              label: Text(
                "Female",
                style: TextStyle(
                  color: controller.gender.value == "Female"
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              selected: controller.gender.value == "Female",
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.background,
              onSelected: (val) {
                if (val) controller.gender.value = "Female";
              },
            ),
          ],
        ),
      ),
    );
  }

  // ===================== DATE OF BIRTH =====================
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
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
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: controller.dobController.text.isNotEmpty
                ? DateTime.tryParse(controller.dobController.text)!
                : DateTime(1990, 1, 1),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (picked != null) {
            controller.dobController.text = DateFormat(
              'yyyy-MM-dd',
            ).format(picked);
          }
        },
      ),
    );
  }
}
