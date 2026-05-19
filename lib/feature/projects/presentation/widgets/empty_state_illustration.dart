import 'package:bridge_x/core/utils/app_shadow.dart';
import 'dart:math';

import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Decorative illustration shown when the user has no projects.
///
/// Consists of a dashed circle, a rocket icon, a central "+" button,
/// and two floating tag chips ("New Idea" & "Collaboration").
class EmptyStateIllustration extends StatelessWidget {
  const EmptyStateIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: double.infinity,
      height: 260.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Dashed circle ──
          CustomPaint(
            size: Size(220.w, 220.w),
            painter: _DashedCirclePainter(
              color: colors.divider.withValues(alpha: 0.6),
              strokeWidth: 1.5,
            ),
          ),

          // ── Rocket icon (top-right) ──
          Positioned(
            top: 10.h,
            right: 30.w,
            child: Icon(
              Icons.rocket_launch_outlined,
              size: 48.sp,
              color: colors.divider.withValues(alpha: 0.45),
            ),
          ),

          // ── Central "+" button ──
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navyBlue.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 28.sp,
            ),
          ),

          // ── "New Idea" tag (left side) ──
          Positioned(
            left: 0,
            top: 80.h,
            child: _FloatingTag(
              icon: Icons.auto_awesome,
              label: 'New Idea',
              backgroundColor: colors.surface,
              iconColor: colors.primary,
              textColor: colors.textPrimary,
            ),
          ),

          // ── "Collaboration" tag (right side) ──
          Positioned(
            right: 0,
            bottom: 40.h,
            child: _FloatingTag(
              icon: Icons.groups_outlined,
              label: 'Collaboration',
              backgroundColor: colors.accent.withValues(alpha: 0.1),
              iconColor: colors.accent,
              textColor: colors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Floating tag chip ───────────────────────────────────────────────────────
class _FloatingTag extends StatelessWidget {
  const _FloatingTag({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        boxShadow: AppShadow.subtle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: iconColor),
          HorizontalSpacing(AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dashed-circle painter ───────────────────────────────────────────────────
class _DashedCirclePainter extends CustomPainter {
  const _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    const dashCount = 60;
    const dashArc = (2 * pi) / dashCount;
    const gapFraction = 0.4;

    for (var i = 0; i < dashCount; i++) {
      final startAngle = i * dashArc;
      final sweepAngle = dashArc * (1 - gapFraction);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}

