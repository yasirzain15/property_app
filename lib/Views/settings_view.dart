import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import '../Core/Constants/colors.dart';
import '../Core/Constants/app_assets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: AppColors.background),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage(AppAssets.profile),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: settings.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = settings[index];
                  return ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: AppColors.primary,
                    ),
                    title: Text(item['title'] as String),
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
