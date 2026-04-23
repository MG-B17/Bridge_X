import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/v_space.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  Widget _buildSocialButton(BuildContext context, {required Widget icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          border: Border.all(color: context.colors.textHint.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 8.w),
            Text(
              label,
              style: context.bodyLarge.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialButton(
          context,
          icon: SvgPicture.asset("assets/svg/google_icon.svg"),
          label: 'Google',
          onTap: () {},
        ),
        VSpace(context.spacing.md),
        _buildSocialButton(
          context,
          icon: SvgPicture.asset("assets/svg/gitHub_icon.svg"), 
          label: 'GitHub',
          onTap: () {},
        ),
      ],
    );
  }
}
