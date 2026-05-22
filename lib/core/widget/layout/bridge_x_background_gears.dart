import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BridgeXBackgroundGears extends StatelessWidget {
  const BridgeXBackgroundGears({
    super.key,
    this.icon,
    this.image = "assets/svgs/bridge_x_app_icon.svg",
  });

  final IconData? icon;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return icon == null ? _logoGear(context: context) : _iconGear(context: context);
  }

  Widget _iconGear({required BuildContext context}) {
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

  Widget _buildLogoGear(
    BuildContext context, {
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Icon(
        Icons.circle,
        color: context.appColors.teal.withValues(alpha: .25),
        size: 6.w,
      ),
    );
  }

  Widget _logoGear({required BuildContext context}) {
    return IgnorePointer(
      child: Stack(
        children: [
          _buildLogoGear(context, top: 12.h, left: 8.w),

          _buildLogoGear(context, top: 18.h, right: 12.w),

          _buildLogoGear(context, top: 40.h, left: 80.w),

          _buildLogoGear(context, top: 55.h, right: 90.w),

          _buildLogoGear(context, top: 75.h, left: 18.w),

          _buildLogoGear(context, top: 90.h, left: 120.w),

          _buildLogoGear(context, top: 95.h, right: 15.w),

          _buildLogoGear(context, top: 110.h, right: 110.w),

          _buildLogoGear(context, top: 140.h, left: 70.w),

          _buildLogoGear(context, top: 150.h, right: 70.w),

          _buildLogoGear(context, top: 170.h, left: 10.w),

          _buildLogoGear(context, top: 180.h, left: 130.w),

          _buildLogoGear(context, top: 190.h, right: 8.w),

          _buildLogoGear(context, top: 200.h, right: 120.w),

          _buildLogoGear(context, top: 230.h, left: 90.w),

          _buildLogoGear(context, top: 240.h, left: 15.w),

          _buildLogoGear(context, top: 250.h, right: 90.w),

          _buildLogoGear(context, top: 265.h, right: 20.w),

          _buildLogoGear(context, top: 280.h, left: 140.w),

          _buildLogoGear(context, top: 300.h, right: 140.w),

          _buildLogoGear(context, top: 320.h, left: 12.w),

          _buildLogoGear(context, top: 340.h, right: 10.w),
        ],
      ),
    );
  }
}
