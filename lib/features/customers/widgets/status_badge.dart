import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../../../core/theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  final CustomerStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color dotColor;
    Color textColor;
    String label;

    switch (status) {
      case CustomerStatus.active:
        backgroundColor = AppColors.successSoft;
        dotColor = AppColors.success;
        textColor = AppColors.success;
        label = 'Active';
        break;
      case CustomerStatus.prospect:
        backgroundColor = AppColors.info.withOpacity(0.1);
        dotColor = AppColors.info;
        textColor = AppColors.info;
        label = 'Prospect';
        break;
      case CustomerStatus.inactive:
        backgroundColor = AppColors.surfaceSecondary;
        dotColor = AppColors.textMuted;
        textColor = AppColors.textSecondary;
        label = 'Inactive';
        break;
      default:
        backgroundColor = AppColors.warningSoft;
        dotColor = AppColors.warning;
        textColor = AppColors.warning;
        label = 'Pending';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
