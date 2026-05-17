import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BridgeXBackgroundGears extends StatelessWidget {
  const BridgeXBackgroundGears({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          _buildGear(context, top: 40.h, left: 30.w, size: 60.w),
          _buildGear(context, top: 60.h, right: 80.w, size: 80.w),
          _buildGear(context, top: 200.h, left: 100.w, size: 120.w),
          _buildGear(context, top: 320.h, right: 50.w, size: 90.w),
          _buildGear(context, top: 450.h, left: 180.w, size: 100.w),
          _buildGear(context, top: 580.h, left: 40.w, size: 70.w),
          _buildGear(context, top: 700.h, right: 120.w, size: 110.w),
          _buildGear(context, bottom: 50.h, left: 60.w, size: 140.w),
        ],
      ),
    );
  }

  Widget _buildGear(BuildContext context, {double? top, double? left, double? right, double? bottom, required double size}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Icon(
        Icons.settings,
        size: size,
        color: context.colors.primary.withValues(alpha: 0.03), // Very faint
      ),
    );
  }
}
