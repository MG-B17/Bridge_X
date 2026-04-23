import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';

class TeamTypeCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const TeamTypeCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: context.spacing.md),
        padding: EdgeInsets.all(context.spacing.lg),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDBEAFE).withValues(alpha: 0.5) : Colors.white,
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _buildIcon(context),
            HSpace(context.spacing.md),
            Expanded(child: _buildContent(context)),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: context.colors.primary, size: 24.w),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isSelected ? context.colors.primary : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : context.colors.textSecondary,
        size: 24.w,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.bodyLarge.copyWith(fontWeight: FontWeight.w900, color: context.colors.textPrimary),
        ),
        VSpace(context.spacing.xs),
        Text(
          description,
          style: context.labelSmall.copyWith(color: context.colors.textSecondary, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
