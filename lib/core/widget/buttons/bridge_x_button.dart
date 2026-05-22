import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BridgeXButton extends StatelessWidget {
  const BridgeXButton({
    super.key,
    required this.text,
    required this.onTap,
    this.prefixicon,
    this.suffixicon,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final IconData? prefixicon;
  final IconData? suffixicon;

  static const _gradient = AppColorScheme.gradient;

  static const _shadowColor = AppColors.primaryBlue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Opacity(
        opacity: (isLoading || onTap == null) ? 0.65 : 1.0,
        child: Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: _gradient,
            boxShadow: [
              BoxShadow(
                color: _shadowColor.withValues(alpha: 0.40),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5.w,
                  children: [
                    prefixicon != null? Icon(prefixicon, color: context.colors.surface, size: 20.sp) :SizedBox.shrink(),
                    Text(
                      text,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        fontSize: 17.sp,
                      ),
                    ),
                    HorizontalSpacing(8),
                    suffixicon != null? Icon(suffixicon, color: context.colors.surface, size: 20.sp) :SizedBox.shrink(),
                  ],
                ),
        ),
      ),
    );
  }
}
