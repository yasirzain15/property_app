import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/property_controller.dart';
import '../Widgets/property_list_card.dart';
import '../Widgets/search_bar_widget.dart';
import '../Core/Routes/app_routes.dart';
import '../Core/Constants/colors.dart';

class PropertyListView extends StatelessWidget {
  PropertyListView({super.key});

  /// 🔮 Controller (Injected via Binding)
  final PropertyController controller = Get.find<PropertyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= TITLE =================
              const Text(
                "All Properties",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 16),

              /// ================= SEARCH =================
              SearchBarWidget(
                hint: "Search by location, city, zip",
                onChanged: (value) {
                  // 🔮 Future API search
                  // controller.searchProperties(value);
                },
              ),

              const SizedBox(height: 20),

              /// ================= PROPERTY LIST =================
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    itemCount: controller.properties.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = controller.properties[index];

                      return GestureDetector(
                        onTap: () {
                          /// 🔮 Navigate to detail screen
                          Get.toNamed(
                            AppRoutes.propertyDetail,
                            arguments: {
                              'title': item.title,
                              'price': item.price,
                              'images': item.image,
                            },
                          );
                        },

                        /// 🧩 CARD
                        child: PropertyListCard(
                          image: item.image,
                          price: item.price,
                          title: item.title,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
