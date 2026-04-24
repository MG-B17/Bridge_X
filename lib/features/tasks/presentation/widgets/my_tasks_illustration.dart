import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

class MyTasksIllustration extends StatelessWidget {
  const MyTasksIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      height: 280.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildBackground(context),
          _buildCard(context),
          _buildStarBadge(context),
          _buildPlantCircle(context),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Container(
      width: 240.w,
      height: 240.w,
      decoration: BoxDecoration(
        color: context.colors.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(32.r),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      width: 140.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: context.colors.secondary.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_box_rounded,
              color: context.colors.primary,
              size: 24.w,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 60.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: context.colors.divider,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: 40.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: context.colors.divider.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarBadge(BuildContext context) {
    return Positioned(
      right: 55.w,
      top: 40.h,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: const Color(0xFFFDE8D0),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFDE8D0).withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.star_rounded,
          color: const Color(0xFF8B6914),
          size: 22.w,
        ),
      ),
    );
  }

  Widget _buildPlantCircle(BuildContext context) {
    return Positioned(
      left: 40.w,
      bottom: 35.h,
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF2D5A3D),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.eco_rounded,
          color: const Color(0xFF8BC34A),
          size: 28.w,
        ),
      ),
    );
  }
}
