import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import 'package:rent_pay/Widgets/common_app_bar.dart';
import '../Core/Constants/colors.dart';
import '../Core/Constants/app_assets.dart';
import '../Controller/auth/logout_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logoutController = Get.find<LogoutController>();

    final settings = [
      {
        'icon': Icons.person,
        'title': 'My Profile',
        'onTap': () => Get.toNamed(AppRoutes.profileview),
      },
      {
        'icon': Icons.install_mobile,
        'title': 'Installments',
        'onTap': () => Get.toNamed(AppRoutes.installments),
      },
      {
        'icon': Icons.language,
        'title': 'Languages',
        'onTap': () => Get.toNamed(AppRoutes.payment),
      },
      {
        'icon': Icons.description,
        'title': 'Terms & Conditions',
        'onTap': () {},
      },
      {'icon': Icons.lock, 'title': 'Privacy Policy', 'onTap': () {}},
      {'icon': Icons.info, 'title': 'About Us', 'onTap': () {}},

      // ✅ Logout item
      {
        'icon': Icons.logout,
        'title': 'Logout',
        'onTap': () {
          Get.defaultDialog(
            title: "Logout",
            titleStyle: TextStyle(color: AppColors.primary),
            middleText: "Are you sure you want to logout?",
            textCancel: "Cancel",
            textConfirm: "Logout",
            confirmTextColor: Colors.white,
            onConfirm: () async {
              Get.back();

              await logoutController.logout(
                name: "Nabeela Kanwal",
                nic: "31205-5635353-3",
                email: "nabeela131@gmail.com",
                mobileNo: "033247878844",
                password: "12345678",
              );
            },
          );
        },
      },
    ];

    return Scaffold(
      appBar: const CommonAppBar(title: "Settings"),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Profile Image
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage(AppAssets.profile),
              ),
            ),

            const SizedBox(height: 20),

            // Settings List
            Expanded(
              child: ListView.separated(
                itemCount: settings.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = settings[index];
                  final isLogout = item['title'] == 'Logout';

                  return ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: isLogout ? Colors.red : AppColors.primary,
                    ),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                        color: isLogout ? Colors.red : Colors.black,
                        fontWeight: isLogout
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: item['onTap'] as void Function()?,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
