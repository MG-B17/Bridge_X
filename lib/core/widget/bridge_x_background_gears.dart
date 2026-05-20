import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BridgeXBackgroundGears extends StatelessWidget {
  const BridgeXBackgroundGears({super.key, this.icon = Icons.settings});

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          _buildGear(context, top: 20.h, left: 20.w, size: 55.w),

          _buildGear(context, top: 18.h, right: 18.w, size: 50.w),

          _buildGear(context, top: 120.h, left: 28.w, size: 48.w),

          _buildGear(context, top: 70.h, left: 170.w, size: 42.w),

          _buildGear(context, top: 240.h, left: 8.w, size: 58.w),

          _buildGear(context, top: 210.h, right: 10.w, size: 60.w),

          _buildGear(context, top: 360.h, right: 40.w, size: 54.w),

          _buildGear(context, top: 430.h, left: 130.w, size: 52.w),

          _buildGear(context, top: 560.h, left: 15.w, size: 50.w),

          _buildGear(context, top: 620.h, right: 28.w, size: 46.w),

          _buildGear(context, top: 760.h, left: 22.w, size: 55.w),

          _buildGear(context, top: 840.h, right: 20.w, size: 58.w),
        ],
      ),
    );
  }

  Widget _buildGear(
    BuildContext context, {
    double? top,
    double? left,
    double? right,
    double? bottom,
    required double size,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Icon(
        icon,
        size: size,
        color: context.colors.secondary.withValues(alpha: 0.06), // Very faint
      ),
    );
  }
}
