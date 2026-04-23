import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';

class RoleCardWidget extends StatelessWidget {
  final String label;
  final String role;
  final String description;

  const RoleCardWidget({
    super.key,
    required this.label,
    required this.role,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        gradient: const LinearGradient(
          colors: [Color(0xFF274C9E), Color(0xFF83A0E7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF274C9E).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          VSpace(context.spacing.md),
          Text(
            role,
            style: context.displayLarge.copyWith(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          VSpace(context.spacing.xs),
          Text(
            description,
            style: context.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.badge_outlined, color: Colors.white.withValues(alpha: 0.8), size: 20.w),
        HSpace(context.spacing.sm),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
