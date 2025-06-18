import 'package:flutter/material.dart';
import 'package:test_project/consts/app_colors.dart';

class Button extends StatelessWidget {
  final VoidCallback onTapped;
  final String text;
  final IconData icon;
  final bool fullWidth;
  const Button({
    super.key,
    required this.onTapped,
    required this.text,
    required this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: 55,
        width: fullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: AppColors.background,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: AppColors.background, size: 20),
          ],
        ),
      ),
    );
  }
}
