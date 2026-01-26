import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Constants/app_assets.dart';
import 'package:rent_pay/Controller/bottom_nav_controller.dart';
import 'package:rent_pay/Core/Constants/ui_constants.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import 'package:rent_pay/Models/agency_model.dart';
import 'package:rent_pay/Views/notifications_view.dart';
import 'package:rent_pay/Widgets/Dashboard/agency_card.dart';
import 'package:rent_pay/Widgets/custom_bottom_nav.dart';
import 'package:rent_pay/Widgets/search_bar_widget.dart';
import 'package:rent_pay/Widgets/property_card.dart';
import 'package:rent_pay/Utils/global_loader.dart';

// Screens
import 'property_list_view.dart';
import 'settings_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final BottomNavController navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      /// 🔻 Bottom Navigation
      bottomNavigationBar: Obx(
        () => CustomBottomNav(
          currentIndex: navController.currentIndex.value,
          onTap: navController.changeIndex,
        ),
      ),

      /// 🔄 Screen Switching
      body: SafeArea(
        child: Obx(() {
          switch (navController.currentIndex.value) {
            case 0:
              return _homeContent();
            case 1:
              return PropertyListView();
            case 2:
              return const NotificationsView();
            case 3:
              return const SettingsView();
            default:
              return _homeContent();
          }
        }),
      ),
    );
  }

  // ================= NAVIGATE WITH GLOBAL LOADER =================
  Future<void> _navigateWithLoader(
    String routeName, {
    dynamic arguments,
  }) async {
    GlobalLoader.show(); // show loader
    try {
      await Future.delayed(const Duration(seconds: 1)); // simulate API delay
      Get.toNamed(routeName, arguments: arguments);
    } finally {
      GlobalLoader.hide(); // hide loader
    }
  }

  // ================= HOME CONTENT =================
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
          const SizedBox(height: 30),

          /// 🏢 AGENCIES
          _sectionTitle("Agencies"),
          const SizedBox(height: 16),
          _agencyCarousel(),

          const SizedBox(height: 30),

          /// 🏠 PROPERTIES
          _sectionTitle("Properties"),
          const SizedBox(height: 16),
          _propertyCarousel(),

          const SizedBox(
            height: 30,
          ), // ✅ Added spacing between properties and projects
          ///PROJECTS
          _sectionTitle("Projects"),
          const SizedBox(height: 16), // ✅ Adjusted spacing for consistency
          _propertyCarousel(),
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
            navController.changeIndex(3);
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

  // ================= SECTION TITLE =================
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // ================= AGENCY CAROUSEL =================
  Widget _agencyCarousel() {
    final agencies = [
      AgencyModel(
        name: "Prime Estate",
        image: AppAssets.house1,
        projects: [
          PropertyProjectModel(
            image: AppAssets.house1,
            title: "Prime Apartments",
            beds: "2 Bed",
            price: "\$2,700,000",
          ),
          PropertyProjectModel(
            image: AppAssets.house2,
            title: "Luxury Heights",
            beds: "3 Bed",
            price: "\$3,200,000",
          ),
        ],
      ),
      AgencyModel(
        name: "Urban Realtors",
        image: AppAssets.house2,
        projects: [
          PropertyProjectModel(
            image: AppAssets.house3,
            title: "Urban Residency",
            beds: "2 Bed",
            price: "\$2,100,000",
          ),
        ],
      ),
      AgencyModel(
        name: "BridgeFord Properties",
        image: AppAssets.house4,
        projects: [
          PropertyProjectModel(
            image: AppAssets.house3,
            title: "BridgeFord Properties",
            beds: "2 Bed",
            price: "\$4,100,000",
          ),
        ],
      ),
      AgencyModel(
        name: "Westmoor Estates",
        image: AppAssets.house1,
        projects: [
          PropertyProjectModel(
            image: AppAssets.house2,
            title: "Westmoor Estates",
            beds: "3 Bed",
            price: "\$5,100,000",
          ),
        ],
      ),
    ];

    final screenWidth = Get.width;
    final cardWidth = screenWidth * 0.6; // card width 60% of screen for peek

    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: agencies.length,
        padding: const EdgeInsets.only(left: 0, right: 16),
        itemBuilder: (context, index) {
          final agency = agencies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: cardWidth,
              child: AgencyCard(
                activeProjects: agency.projects.length,
                image: agency.image,
                name: agency.name,
                onTap: () {
                  _navigateWithLoader(
                    AppRoutes.agencyDetails,
                    arguments: agency,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= PROPERTY CAROUSEL =================
  Widget _propertyCarousel() {
    final properties = [
      {
        "image": AppAssets.house1,
        "title": "Springdale Heights",
        "beds": "3 Bed",
        "price": "\$2,700,000",
      },
      {
        "image": AppAssets.house2,
        "title": "Lakeside View",
        "beds": "2 Bed",
        "price": "\$2,890,000",
      },
      {
        "image": AppAssets.house3,
        "title": "Hilltop Terrace",
        "beds": "4 Bed",
        "price": "\$2,300,000",
      },
    ];

    final screenWidth = Get.width;
    final cardWidth = screenWidth * 0.6; // 60% of screen width for peek

    return SizedBox(
      height: kCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: properties.length,
        padding: const EdgeInsets.only(left: 0, right: 16),
        itemBuilder: (context, index) {
          final item = properties[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: cardWidth,
              child: PropertyCard(
                image: item["image"]!,
                title: item["title"]!,
                beds: item["beds"]!,
                price: item["price"]!,
                onTap: () {
                  _navigateWithLoader(
                    AppRoutes.propertyDetail,
                    arguments: item,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
