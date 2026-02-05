import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Controller/global_loader_controller.dart';

import 'Core/Constants/colors.dart';
import 'Core/Routes/app_pages.dart';
import 'Core/Routes/app_routes.dart';
import 'Core/Bindings/initial_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ IMPORTANT

  // 🔹 Inject global loader controller permanently
  Get.put(GlobalLoaderController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loader = Get.find<GlobalLoaderController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Property App',

      /// 🌍 REQUIRED FOR Directionality SAFETY
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),

      /// 🎨 THEME
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
      ),

      /// 🧭 ROUTING
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,

      /// 🔗 GLOBAL BINDINGS
      initialBinding: InitialBinding(),

      /// 🚨 BUILDER WITH GLOBAL LOADER
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              child ?? const SizedBox.shrink(),

              /// 🔄 GLOBAL CENTER LOADER
              Obx(() {
                if (!loader.isLoading.value) return const SizedBox.shrink();

                return Container(
                  color: Colors.black.withOpacity(0.15), // optional dim
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 3,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
