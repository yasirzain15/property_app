import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Constants/app_assets.dart';
import 'package:rent_pay/Controller/bottom_nav_controller.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import 'package:rent_pay/Views/notifications_view.dart';
import 'package:rent_pay/Widgets/custom_bottom_nav.dart';
import 'package:rent_pay/Widgets/property_card.dart';
import 'package:rent_pay/Widgets/search_bar_widget.dart';

// Screens
import 'property_list_view.dart';
import 'settings_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final BottomNavController navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,

        /// 🔻 Bottom Navigation
        bottomNavigationBar: Obx(
          () => CustomBottomNav(
            currentIndex: navController.currentIndex.value,
            onTap: navController.changeIndex,
          ),
        ),

        /// 🔄 Screen Switching
        body: Obx(() {
          switch (navController.currentIndex.value) {
            case 0:
              return _homeContent();
            case 1:
              return PropertyListView();
            case 2:
              return const NotificationsView(); // ✅ NOTIFICATIONS
            case 3:
              return const SettingsView();
            default:
              return _homeContent();
          }
        }),
      ),
    );
  }

  // ================= HOME CONTENT =================
  Widget _homeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const SizedBox(height: 24),
          _exploreCard(),
          const SizedBox(height: 30),
          _searchField(),
          const SizedBox(height: 24),
          _propertyGrid(),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.settingssiew);
          },
          child: const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(AppAssets.profile),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "Morning Rushdeen!",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Spacer(),

        /// 🔔 Notification Icon (syncs with bottom nav)
        GestureDetector(
          onTap: () {
            navController.changeIndex(2);
          },
          child: const Icon(
            Icons.notifications_none,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // ================= EXPLORE CARD =================
  Widget _exploreCard() {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Rental\nExplore",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Text("127 near you", style: TextStyle(color: Colors.white)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  // ================= SEARCH =================
  Widget _searchField() {
    return const SearchBarWidget(hint: "Address, city, zip");
  }

  // ================= PROPERTY GRID =================
  Widget _propertyGrid() {
    final List<Map<String, String>> properties = [
      {
        "image": AppAssets.house1,
        "title": "Springdale Heights",
        "price": "\$2,700,000",
      },
      {
        "image": AppAssets.house2,
        "title": "Lakeside View",
        "price": "\$2,890,000",
      },
      {
        "image": AppAssets.house3,
        "title": "Hilltop Terrace",
        "price": "\$2,300,000",
      },
      {
        "image": AppAssets.house4,
        "title": "Riverside Park",
        "price": "\$2,400,000",
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: properties.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        final item = properties[index];
        return PropertyCard(
          image: item["image"]!,
          title: item["title"]!,
          price: item["price"]!,
        );
      },
    );
  }
}
