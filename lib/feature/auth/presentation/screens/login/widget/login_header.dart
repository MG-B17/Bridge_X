import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacing(AppSpacing.headerTop),
        SvgPicture.asset(
          'assets/svgs/bridge_x_app_icon.svg',
          width: AppSpacing.logoWidth,
          height: AppSpacing.logoHeight,
          fit: BoxFit.cover,
        ),
        VerticalSpacing(AppSpacing.xxl),
      ],
    );
  }
}
