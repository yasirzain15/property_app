import 'package:flutter/material.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Constants/ui_constants.dart';

class AgencyCard extends StatelessWidget {
  final String image;
  final String name;
  final int activeProjects;
  final VoidCallback onTap;

  const AgencyCard({
    super.key,
    required this.image,
    required this.name,
    required this.activeProjects,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kCardWidth, // ✅ SAME AS PROPERTY CARD
      height: kCardHeight, // ✅ SAME HEIGHT
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14), // ✅ SAME RADIUS
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(14), // ✅ SAME
              child: Image.asset(
                image,
                height: kImageHeight, // ✅ SAME IMAGE HEIGHT
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 6),

            /// NAME
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),

            /// ACTIVE PROJECTS
            Text(
              "Active Projects\n$activeProjects",
              style: const TextStyle(fontSize: 12, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
