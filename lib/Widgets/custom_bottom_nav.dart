import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_pay/Core/Constants/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,

          // 🔧 NAV BAR ROUNDNESS (adjust as needed)
          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(CupertinoIcons.home, 0),
            _navItem(CupertinoIcons.list_bullet, 1), // ✅ SAME AS BEFORE
            _navItem(Icons.notifications_none_outlined, 2),
            _navItem(CupertinoIcons.person_alt_circle, 3),
          ],
        ),
      ),
    );
  }

  /// ---------------- NAV ITEM (API READY) ----------------
  Widget _navItem(IconData icon, int index) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.12)
              : Colors.transparent,

          // 🔧 ICON BACKGROUND ROUNDNESS
          borderRadius: BorderRadius.circular(12),
        ),

        child: Icon(
          icon,
          size: 24,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
