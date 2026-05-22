import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BridgeXDivider extends StatelessWidget {
  const BridgeXDivider({
    this.height = 16,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
    super.key,
  });

  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height.h,
      thickness: thickness.h,
      indent: indent.w,
      endIndent: endIndent.w,
      color: color ?? context.colors.divider,
    );
  }
}
