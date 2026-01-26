import 'package:flutter/material.dart';
import 'package:rent_pay/Core/Constants/colors.dart';
import 'package:rent_pay/Core/Constants/ui_constants.dart';

class PropertyCard extends StatelessWidget {
  final String image;
  final String title;
  final String beds;
  final String price;
  final VoidCallback onTap;

  const PropertyCard({
    super.key,
    required this.image,
    required this.title,
    required this.beds,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kCardWidth, // ✅ SAME AS AGENCY
      height: kCardHeight,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                image,
                height: kImageHeight, // ✅ SAME IMAGE HEIGHT
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 6),

            /// TITLE
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),

            /// BEDS
            Text(
              beds,
              style: const TextStyle(fontSize: 11, color: AppColors.primary),
            ),

            /// PRICE
            Text(
              price,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
