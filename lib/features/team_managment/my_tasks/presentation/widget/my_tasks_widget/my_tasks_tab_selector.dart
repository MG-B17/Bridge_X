import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class MyTasksTabSelector extends StatelessWidget {
  const MyTasksTabSelector({
    super.key,
    required this.isActiveTab,
    required this.onTabChanged,
  });

  final bool isActiveTab;
  final ValueChanged<bool> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: context.colors.divider.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
      ),
      child: Row(
        children: [
          _buildTabButton(
            context,
            'Active',
            isActiveTab,
            () => onTabChanged(true),
          ),
          _buildTabButton(
            context,
            'Completed',
            !isActiveTab,
            () => onTabChanged(false),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.primary.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: isSelected ? context.colors.primary : context.colors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
