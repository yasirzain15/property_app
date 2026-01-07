import 'package:flutter/material.dart';
import 'package:rent_pay/Core/Constants/colors.dart';

class FbNotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String description;
  final String time;
  final bool isUnread;

  const FbNotificationTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.description,
    required this.time,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isUnread ? Colors.blue.withOpacity(0.05) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconBg, size: 22),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: " $description"),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          /// UNREAD DOT
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(left: 8, top: 6),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
