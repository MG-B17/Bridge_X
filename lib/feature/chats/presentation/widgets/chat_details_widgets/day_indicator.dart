import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';

class DayIndicator extends StatelessWidget {
  final String day;

  const DayIndicator({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing16,
          vertical: AppSpacing.height4,
        ),
        decoration: BoxDecoration(
          color: context.colors.primaryLight,
          borderRadius: BorderRadius.circular(AppSpacing.radius20),
        ),
        child: Text(
          day,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
