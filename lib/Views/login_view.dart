import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import 'package:rent_pay/Widgets/custom_button.dart';
import 'package:rent_pay/Widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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

              /// Email
              const CustomTextField(
                hint: "Email address",
                icon: Icons.email, // ✅ Added prefix icon
              ),

              const SizedBox(height: 16),

              /// Password
              CustomTextField(
                hint: "Password",
                isPassword: true,
                icon: Icons.lock, // ✅ Added prefix icon
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off),
                ),
              ),

              const SizedBox(height: 10),

              /// Forgot password
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

              const SizedBox(height: 10),

              /// Login button
              CustomButton(
                title: "Log In",
                onTap: () {
                  // ✅ Route-based navigation
                  Get.offAllNamed(AppRoutes.home);
                },
              ),

              const Spacer(),

              /// Sign up text
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
