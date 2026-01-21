import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_pay/Widgets/Dashboard/agency_project_card.dart';
import '../Controller/agency_details_controller.dart';
import '../Core/Constants/colors.dart';

class AgencyDetailsView extends StatelessWidget {
  AgencyDetailsView({super.key});

  final controller = Get.find<AgencyDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,

        /// 🍎 iOS BACK BUTTON
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          child: const Icon(CupertinoIcons.back, color: Colors.white, size: 28),
        ),

        title: Text(
          controller.agency.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

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
                  return AgencyProjectCard(
                    project: controller.agency.projects[index],
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
