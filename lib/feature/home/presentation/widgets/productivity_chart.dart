import 'dart:math' as math;
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'legend_item.dart';

class ProductivityChart extends StatelessWidget {
  const ProductivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.colors.surface, const Color(0xFFF7FBFF), const Color(0xFFEAF6FF)],
          stops: const [0.0, 0.65, 1.0],
        ),

        border: Border.all(color: const Color(0xFFC3D6E2).withValues(alpha: 0.20), width: 1),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: const Color(0xFF80BBFF).withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
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
          HorizontalSpacing(AppSpacing.xl),
          // ── Legend ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendItem(color: context.colors.primary, label: AppStrings.completedTasks),
                VerticalSpacing(AppSpacing.sm),
                LegendItem(color: context.colors.divider, label: AppStrings.activeTasks),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Custom donut chart painter ──────────────────────────────────────────────
class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.percentage, required this.activeColor, required this.inactiveColor});

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
  bool shouldRepaint(covariant _DonutPainter oldDelegate) => oldDelegate.percentage != percentage;
}
