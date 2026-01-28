import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Core/Routes/app_routes.dart';
import 'package:rent_pay/Widgets/Dashboard/agency_project_card.dart';
import 'package:rent_pay/Utils/global_loader.dart';
import 'package:rent_pay/Widgets/common_app_bar.dart';

import '../Controller/agency_details_controller.dart';
import '../Core/Constants/colors.dart';

class AgencyDetailsView extends StatelessWidget {
  AgencyDetailsView({super.key});

  final controller = Get.find<AgencyDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(title: controller.agency.name, showBack: true),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                controller.agency.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Projects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: controller.agency.projects.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final project = controller.agency.projects[index];

                  return GestureDetector(
                    onTap: () async {
                      /// 🔄 SHOW LOADER FIRST
                      GlobalLoader.show();

                      await Future.delayed(const Duration(milliseconds: 800));

                      /// 👉 NAVIGATE
                      Get.toNamed(
                        AppRoutes.propertyDetail,
                        arguments: {
                          'title': project.title,
                          'price': project.price,
                          'images': [
                            project.image,
                            project.image,
                            project.image,
                          ],
                        },
                      );

                      /// ❌ HIDE LOADER AFTER NAVIGATION
                      GlobalLoader.hide();
                    },
                    child: AgencyProjectCard(project: project),
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
