import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/extensions.dart';
import '../theme/app_color_scheme.dart';
import 'h_space.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final Widget? trailing;
  final Widget? leading;
  final Color? backgroundColor;
  final Gradient? gradient;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.trailing,
    this.leading,
    this.backgroundColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        gradient: (isSecondary || backgroundColor != null) ? null : (gradient ?? AppColorScheme.gradient),
        color: (isSecondary || gradient != null) ? null : backgroundColor,
        border: isSecondary ? Border.all(color: context.colors.primary, width: 1.w) : null,
        boxShadow: isSecondary ? null : [
          BoxShadow(
            color: (backgroundColor ?? context.colors.primary).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: isSecondary ? context.colors.primary : Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: context.spacing.xl,
                height: context.spacing.xl,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isSecondary ? context.colors.primary : Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    HSpace(context.spacing.sm),
                  ],
                  Text(
                    label,
                    style: context.bodyLarge.copyWith(
                      color: isSecondary ? context.colors.primary : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (trailing != null) ...[
                    HSpace(context.spacing.sm),
                    trailing!,
                  ],
                ],
              ),
      ),
    );
  }
}

