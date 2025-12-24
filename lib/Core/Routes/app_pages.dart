import 'package:get/get.dart';
import 'package:rent_pay/Core/Bindings/notifications_binding.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';

// Views
import 'package:rent_pay/Views/login_view.dart';
import 'package:rent_pay/Views/home_view.dart';
import 'package:rent_pay/Views/notifications_view.dart';
import 'package:rent_pay/Views/property_list_view.dart';
import 'package:rent_pay/Views/property_detail_view.dart';
import 'package:rent_pay/Views/settings_view.dart';
import 'package:rent_pay/Views/profile_view.dart';

// Bindings
import 'package:rent_pay/Core/Bindings/home_binding.dart';
import 'package:rent_pay/Core/Bindings/property_binding.dart';
import 'package:rent_pay/Core/Bindings/settings_binding.dart';
import 'package:rent_pay/Core/Bindings/profile_binding.dart';

class AppPages {
  AppPages._();

  static final routes = [
    /// 🔐 LOGIN
    GetPage(name: AppRoutes.login, page: () => const LoginView()),

    /// 🏠 HOME
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),

    /// 🏢 PROPERTY LIST
    GetPage(
      name: AppRoutes.propertyList,
      page: () => PropertyListView(),
      binding: PropertyBinding(),
    ),

    /// 🏡 PROPERTY DETAIL
    GetPage(
      name: AppRoutes.propertyDetail,
      page: () => const PropertyDetailView(),
      binding: PropertyBinding(),
    ),

    /// ⚙️ SETTINGS
    GetPage(
      name: AppRoutes.settingssiew,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),

    /// 👤 PROFILE
    GetPage(
      name: AppRoutes.profileview,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

    /// 🔔 NOTIFICATIONS
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
  ];
}
