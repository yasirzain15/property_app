import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/project_properties_controller.dart';
import '../Core/Constants/colors.dart';
import '../Widgets/common_app_bar.dart';

class ProjectPropertiesView extends StatelessWidget {
  const ProjectPropertiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectPropertiesController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(title: controller.project.title, showBack: true),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: controller.properties.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, index) {
            final property = controller.properties[index];

            return GestureDetector(
              onTap: () => controller.openPropertyDetail(property),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    /// IMAGE
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(18),
                      ),
                      child: Image.asset(
                        property.image,
                        width: 110,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            property.price,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
