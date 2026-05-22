import 'dart:math' as math;
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_gradient.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'legend_item.dart';

class ProductivityChart extends StatelessWidget {
  const ProductivityChart({super.key, this.completionRate});

  final double? completionRate;

  @override
  Widget build(BuildContext context) {
    final double donutSize = 110.w;
    final double percentage = (completionRate ?? 0.0) / 100;
    final String label = '${(completionRate ?? 0.0).toInt()}%';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: AppGradient.productivityCard(
          primaryLight: context.colors.primaryLight,
          teal: context.colors.teal,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(
          color: context.colors.divider,
        ),
        boxShadow:AppShadow.card,
      ),
      child: Row(
        children: [
          // ── Donut chart ──
          SizedBox(
            width: donutSize,
            height: donutSize,
            child: CustomPaint(
              painter: _DonutPainter(
                percentage: percentage,
                activeColor: context.colors.primary,
                inactiveColor: context.colors.divider,
              ),
              child: Center(
                child: Text(
                  label,
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
                LegendItem(color: context.colors.secondary, label: AppStrings.completedTasks),
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
