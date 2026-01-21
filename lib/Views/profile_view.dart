import 'dart:io';

import 'package:flutter/cupertino.dart';
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
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          child: const Icon(
            CupertinoIcons.back,
            color: AppColors.background,
            size: 26,
          ),
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
                    radius: 60,
                    backgroundColor: AppColors.primary.withOpacity(0.5),
                    backgroundImage: controller.profileImage.value.isNotEmpty
                        ? FileImage(File(controller.profileImage.value))
                        : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
                  ),
                ),
              ),

              const SizedBox(height: 24),

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

              const SizedBox(height: 32),

              /// UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.primary,
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    GlobalLoader.show();
                    try {
                      await Future.delayed(const Duration(seconds: 2));
                      await controller.updateProfile();
                    } finally {
                      GlobalLoader.hide();
                    }
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

            /// MALE
            ChoiceChip(
              label: Text(
                "Male",
                style: TextStyle(
                  color: controller.gender.value == "Male"
                      ? Colors.white
                      : AppColors.primary,
                ),
              ),
              selected: controller.gender.value == "Male",
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.background,
              shape: StadiumBorder(side: BorderSide(color: AppColors.primary)),
              onSelected: (val) {
                if (val) controller.gender.value = "Male";
              },
            ),

            const SizedBox(width: 10),

            /// FEMALE
            ChoiceChip(
              label: Text(
                "Female",
                style: TextStyle(
                  color: controller.gender.value == "Female"
                      ? Colors.white
                      : AppColors.primary,
                ),
              ),
              selected: controller.gender.value == "Female",
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.background,
              shape: StadiumBorder(side: BorderSide(color: AppColors.primary)),
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
                ? DateTime.tryParse(controller.dobController.text)
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
