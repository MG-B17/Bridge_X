import 'dart:math' as math;
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_gradient.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'legend_item.dart';

class ProductivityChart extends StatelessWidget {
  const ProductivityChart({super.key});

  static const double _chartPercentage = 0.65;
  static const String _chartLabel      = '65%';

  @override
  Widget build(BuildContext context) {
    final double donutSize = 110.w;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        gradient: AppGradient.productivityCardFull(surface: context.colors.surface),
        border: Border.all(
          color: context.colors.divider.withValues(alpha: 0.20),
        ),
        boxShadow: AppShadow.chartCard,
      ),
      child: Row(
        children: [
          // ── Donut chart ──
          SizedBox(
            width: donutSize,
            height: donutSize,
            child: CustomPaint(
              painter: _DonutPainter(
                percentage: _chartPercentage,
                activeColor: context.colors.primary,
                inactiveColor: context.colors.divider.withValues(alpha: 0.3),
              ),
              child: Center(
                child: Text(
                  _chartLabel,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing24),
          // ── Legend ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendItem(color: context.colors.primary, label: AppStrings.completedTasks),
                VerticalSpacing(AppSpacing.spacing8),
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

  static const double _strokeWidth = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect   = Rect.fromCircle(center: center, radius: radius - _strokeWidth / 2);

    canvas.drawArc(rect, 0, 2 * math.pi, false,
      Paint()
        ..color       = inactiveColor
        ..style       = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap   = StrokeCap.round,
    );

    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * percentage, false,
      Paint()
        ..color       = activeColor
        ..style       = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap   = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) => old.percentage != percentage;
}
