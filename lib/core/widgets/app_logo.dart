import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/extensions.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final Color? color;

  const AppLogo({super.key, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.colors.primary;
    
    return SvgPicture.asset(
      'assets/svg/Group 1171275954 (1).svg',
      width: width ?? 64.w,
      colorFilter: ColorFilter.mode(effectiveColor, BlendMode.srcIn),
      errorBuilder: (context, error, stackTrace) {
        return Text(
          'BX',
          style: context.displayLarge.copyWith(
            color: effectiveColor,
            fontSize: (width ?? 64.w) / 2, // Approximate font size based on width
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        );
      },
    );
  }
}
