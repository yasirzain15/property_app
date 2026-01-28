import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/auth/login_controller.dart';

import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Widgets/custom_button.dart';
import 'package:rent_pay/Widgets/cnic_textfield.dart';
import 'package:rent_pay/Widgets/custom_textfield.dart'; // ✅ import new CNIC field

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              /// Title
              Center(
                child: Column(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Own it. Rent it. Sell it.\nAll your property needs, one tap away.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// CNIC
              CnicTextField(
                controller: controller.nicController,
              ), // ✅ auto-formatting CNIC

              const SizedBox(height: 16),

              /// Password
              CustomTextField(
                hint: "Password",
                isPassword: true,
                icon: Icons.lock,
                controller: controller.passwordController,
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: AppColors.primary, fontSize: 13),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Login Button
              CustomButton(title: "Log In", onTap: controller.login),

              const Spacer(),

              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don’t have an account? ",
                    style: const TextStyle(color: AppColors.textSecondary),
                    children: const [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
