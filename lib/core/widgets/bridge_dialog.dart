import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_color.dart';
import '../../theme/text_style.dart';
import '../../utils/extensions.dart';
import '../v_space.dart';
import '../bridge_app_button.dart';

class BridgeDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String description;
  final String primaryButtonLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonLabel;
  final VoidCallback? onSecondaryPressed;
  final String? textLinkLabel;
  final VoidCallback? onTextLinkPressed;
  final Widget? extraContent;

  const BridgeDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.description,
    required this.primaryButtonLabel,
    required this.onPrimaryPressed,
    this.secondaryButtonLabel,
    this.onSecondaryPressed,
    this.textLinkLabel,
    this.onTextLinkPressed,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 32.sp),
            ),
            VSpace(20.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: context.colors.textPrimary,
              ),
            ),
            VSpace(12.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
                height: 1.5,
              ),
            ),
            if (extraContent != null) ...[
              VSpace(20.h),
              extraContent!,
            ],
            VSpace(30.h),
            AppButton(
              label: primaryButtonLabel,
              onPressed: onPrimaryPressed,
            ),
            if (secondaryButtonLabel != null) ...[
              VSpace(12.h),
              AppButton(
                label: secondaryButtonLabel!,
                onPressed: onSecondaryPressed ?? () {},
                isSecondary: true,
              ),
            ],
            if (textLinkLabel != null) ...[
              VSpace(16.h),
              TextButton(
                onPressed: onTextLinkPressed,
                child: Text(
                  textLinkLabel!,
                  style: context.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
