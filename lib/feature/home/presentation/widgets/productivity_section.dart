import 'dart:math' as math;
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.yourProductivity,
          style: AppTextStyles.headlineSmall.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        VerticalSpacing(AppSpacing.md),
        const _ProductivityChart(),
      ],
    );
  }
}

// ── Donut chart card ────────────────────────────────────────────────────────
class _ProductivityChart extends StatelessWidget {
  const _ProductivityChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.surface,
            context.colors.primaryLight.withValues(alpha: 0.25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(
          color: context.colors.divider.withValues(alpha: 0.3),
        ),
        boxShadow: AppSpacing.subtleShadow,
      ),
      child: Row(
        children: [
          // ── Donut chart ──
          SizedBox(
            width: 110.w,
            height: 110.w,
            child: CustomPaint(
              painter: _DonutPainter(
                percentage: 0.65,
                activeColor: context.colors.primary,
                inactiveColor: context.colors.divider.withValues(alpha: 0.3),
              ),
              child: Center(
                child: Text(
                  '65%',
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.xl),
          // ── Legend ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LegendItem(
                  color: context.colors.primary,
                  label: AppStrings.completedTasks,
                ),
                SizedBox(height: 12.h),
                _LegendItem(
                  color: context.colors.divider,
                  label: AppStrings.activeTasks,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Legend dot + label ──────────────────────────────────────────────────────
class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Custom donut chart painter ──────────────────────────────────────────────
class _DonutPainter extends CustomPainter {
  _DonutPainter({
    required this.percentage,
    required this.activeColor,
    required this.inactiveColor,
  });

  final double percentage;
  final Color activeColor;
  final Color inactiveColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 12.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    // Background arc
    final bgPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * math.pi, false, bgPaint);

    // Active arc
    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * percentage;
    canvas.drawArc(rect, startAngle, sweepAngle, false, activePaint);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.percentage != percentage;
}
