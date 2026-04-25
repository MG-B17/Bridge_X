import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import 'dart:math' as math;

class ProjectsEmptyGraphic extends StatelessWidget {
  const ProjectsEmptyGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dashed Circle
          SizedBox(
            width: 220.r,
            height: 220.r,
            child: CustomPaint(
              painter: _DashedCirclePainter(
                color: context.colors.textHint.withValues(alpha: 0.3),
              ),
            ),
          ),
          
          // Rocket outline top right
          Positioned(
            top: 20.h,
            right: 40.w,
            child: Icon(
              Icons.rocket_launch_outlined,
              size: 50.r,
              color: context.colors.textHint.withValues(alpha: 0.4),
            ),
          ),

          // New Idea pill top left
          Positioned(
            top: 60.h,
            left: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(context.spacing.radiusPill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, size: 14.r, color: context.colors.primary),
                  SizedBox(width: 4.w),
                  Text(
                    'New Idea',
                    style: context.labelSmall.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Collaboration pill bottom right
          Positioned(
            bottom: 40.h,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(context.spacing.radiusPill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_alt, size: 14.r, color: Colors.deepOrange),
                  SizedBox(width: 4.w),
                  Text(
                    'Collaboration',
                    style: context.labelSmall.copyWith(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center Plus Icon
          Container(
            width: 120.r,
            height: 120.r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(20.r),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 32.r,
                height: 32.r,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  color: context.colors.primary,
                  size: 24.r,
                  weight: 700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;

  _DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);
    
    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * (dashWidth + dashSpace) / radius;
      final sweepAngle = dashWidth / radius;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
