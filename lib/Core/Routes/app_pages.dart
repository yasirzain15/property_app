import 'package:get/get.dart';
import 'package:rent_pay/Core/Bindings/installment_bindings.dart';
import 'package:rent_pay/Core/Bindings/login_binding.dart';
import 'package:rent_pay/Core/Bindings/notifications_binding.dart';
import 'package:rent_pay/Core/Bindings/payment_binding.dart';
import 'package:rent_pay/Core/Bindings/payment_success_binding.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';

// Views
import 'package:rent_pay/Views/login_view.dart';
import 'package:rent_pay/Views/home_view.dart';
import 'package:rent_pay/Views/installment_view.dart';
import 'package:rent_pay/Views/notifications_view.dart';
import 'package:rent_pay/Views/payment_success_view.dart';
import 'package:rent_pay/Views/payment_view.dart';
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
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

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

    /// 🔔 INSTALLMENTS
    GetPage(
      name: AppRoutes.installments,
      page: () => const InstallmentView(),
      binding: InstallmentBindings(),
    ),

    ///NOTIFICATIONS
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),

    ///PAYMENTS
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),

    ///PAYMENT SUCCESS
    GetPage(
      name: AppRoutes.paymentSuccess,
      page: () => const PaymentSuccessView(),
      binding: PaymentSuccessBinding(),
    ),
  ];
}
