import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class MatchingProgressRing extends StatelessWidget {
  const MatchingProgressRing({
    super.key,
    required this.percentage,
    required this.label,
  });

  final double percentage;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final size = AppSpacing.width180;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Track ring ──
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: percentage / 100,
              trackColor: colors.divider.withValues(alpha: 0.3),
              gradientColors: [colors.teal, colors.primary],
              strokeWidth: AppSpacing.spacing10,
            ),
          ),

          // ── Center text ──
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${percentage.toInt()}%',
                style: AppTextStyles.displayLarge.copyWith(
                  color: colors.textPrimary,
                  fontSize: AppSpacing.fontSize32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              VerticalSpacing(AppSpacing.height2),
              Text(
                label.toUpperCase(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  fontSize: AppSpacing.fontSize10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Custom ring painter ─────────────────────────────────────────────────────
class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.gradientColors,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final List<Color> gradientColors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    // Progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: gradientColors,
    );

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress;
}
