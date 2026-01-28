import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,

      /// 🍎 SAFE CUPERTINO BACK BUTTON
      leading: showBack
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (Get.key.currentState?.canPop() ?? false) {
                  Get.back();
                } else {
                  /// ✅ fallback when no route to pop
                  Get.offAllNamed(AppRoutes.home);
                }
              },
              child: const Icon(
                CupertinoIcons.back,
                color: AppColors.background,
                size: 26,
              ),
            )
          : null,

      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.background,
          fontWeight: FontWeight.w500,
        ),
      ),

      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
