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
    GlobalLoader.show();
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(routeName, arguments: arguments);
    } finally {
      GlobalLoader.hide();
    }
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

          const SizedBox(height: 30),

          /// 🏗 PROJECTS
          _sectionTitle("Projects"),
          const SizedBox(height: 16),
          _projectCarousel(),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => navController.changeIndex(3),
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
          onTap: () => navController.changeIndex(2),
          child: const Icon(Icons.notifications_none),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  Widget _searchField() {
    return const SearchBarWidget(hint: "Address, city, zip");
  }

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
            title: "Twin Towers",
            image: AppAssets.house1,
            beds: "3",
            price: "\$2,800,000",
          ),
          PropertyProjectModel(
            title: "Sky Heights",
            image: AppAssets.house2,
            beds: "2",
            price: "\$2,400,000",
          ),
        ],
      ),
      AgencyModel(
        name: "Urban Realtors",
        image: AppAssets.house2,
        projects: [
          PropertyProjectModel(
            title: "Urban Residency",
            image: AppAssets.house3,
            beds: "4",
            price: "\$3,100,000",
          ),
        ],
      ),
      AgencyModel(
        name: "BridgeFord Properties",
        image: AppAssets.house3,
        projects: [
          PropertyProjectModel(
            title: "BridgeFord Towers",
            image: AppAssets.house4,
            beds: "3",
            price: "\$3,600,000",
          ),
          PropertyProjectModel(
            title: "BridgeFord Villas",
            image: AppAssets.house1,
            beds: "5",
            price: "\$5,200,000",
          ),
        ],
      ),
    ];

    final cardWidth = Get.width * 0.6;

    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: agencies.length,
        padding: const EdgeInsets.only(
          left: 0,
          right: 16,
        ), // left/right padding
        itemBuilder: (_, index) {
          final agency = agencies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12), // spacing between cards
            child: SizedBox(
              width: cardWidth,
              child: AgencyCard(
                image: agency.image,
                name: agency.name,
                activeProjects: agency.projects.length,
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
    ];

    final cardWidth = Get.width * 0.6;

    return SizedBox(
      height: kCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: properties.length,
        padding: const EdgeInsets.only(left: 0, right: 16), // carousel padding
        itemBuilder: (_, index) {
          final item = properties[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12), // spacing between cards
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

  // ================= PROJECT CAROUSEL =================
  Widget _projectCarousel() {
    final projects = [
      PropertyProjectModel(
        title: "Sky Towers",
        image: AppAssets.house1,
        beds: '3',
        price: '\$2,890,000',
      ),
      PropertyProjectModel(
        title: 'Twin Towers',
        beds: '2',
        price: '\$2,890,000',
        image: AppAssets.house2,
      ),
      PropertyProjectModel(
        title: "Emerald Heights",
        image: AppAssets.house3,
        beds: '4',
        price: '\$2,890,000',
      ),
    ];

    final cardWidth = Get.width * 0.6;

    return SizedBox(
      height: kCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        padding: const EdgeInsets.only(left: 0, right: 16), // carousel padding
        itemBuilder: (_, index) {
          final project = projects[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12), // spacing between cards
            child: SizedBox(
              width: cardWidth,
              child: PropertyCard(
                image: project.image,
                title: project.title,
                beds: "Multiple Units", // keep original project text
                price: "Starting Soon", // keep original project text
                onTap: () {
                  _navigateWithLoader(
                    AppRoutes.projectProperties,
                    arguments: project,
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
