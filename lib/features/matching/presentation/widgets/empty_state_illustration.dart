import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import 'illustration_components.dart';

class EmptyStateIllustration extends StatelessWidget {
  const EmptyStateIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      height: 280.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const BackgroundCircles(),
          const IllustrationCard(),
          _buildFloatingSearchIcon(context),
        ],
      ),
    );
  }

  Widget _buildFloatingSearchIcon(BuildContext context) {
    return Positioned(
      right: 60.w,
      top: 110.h,
      child: Transform.rotate(
        angle: -0.1,
        child: Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(color: context.colors.primary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8)),
            ],
          ),
          child: Icon(Icons.search_rounded, color: Colors.white, size: 32.w),
        ),
      ),
    );
  }
}
