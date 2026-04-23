import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

class BackgroundCircles extends StatelessWidget {
  const BackgroundCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 240.w,
          height: 240.w,
          decoration: BoxDecoration(color: context.colors.secondary.withValues(alpha: 0.1), shape: BoxShape.circle),
        ),
        Container(
          width: 180.w,
          height: 180.w,
          decoration: BoxDecoration(color: context.colors.secondary.withValues(alpha: 0.2), shape: BoxShape.circle),
        ),
      ],
    );
  }
}

class IllustrationCard extends StatelessWidget {
  const IllustrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(left: 20.w, top: 30.h, child: _buildFigures()),
          Positioned(right: 15.w, top: 15.h, child: _buildDot()),
        ],
      ),
    );
  }

  Widget _buildFigures() {
    return Row(
      children: [
        _buildFigure(Colors.blue.withValues(alpha: 0.2)),
        SizedBox(width: 4.w),
        _buildFigure(Colors.grey.withValues(alpha: 0.2)),
      ],
    );
  }

  Widget _buildFigure(Color color) {
    return Column(
      children: [
        Container(width: 16.w, height: 16.w, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(height: 4.h),
        Container(width: 24.w, height: 12.h, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6.r))),
      ],
    );
  }

  Widget _buildDot() {
    return Container(width: 12.w, height: 12.w, decoration: const BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle));
  }
}
