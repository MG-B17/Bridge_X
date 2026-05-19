import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BridgeXOutlineButton extends StatelessWidget {
  const BridgeXOutlineButton({
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Opacity(
        opacity: (isLoading || onTap == null) ? 0.65 : 1.0,
        child: Container(
          width: double.infinity,
        height: 50.h,
          decoration:BoxDecoration(
            color:context.colors.surface ,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.colors.textSecondary,width: 1.8.w), 
        ) ,
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation(
                        AppColors.primaryBlue,
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5.w,
                  children: [
                    if (prefixicon != null)
                      Icon(
                        prefixicon,
                        color: context.colors.textSecondary,
                        size: 20.sp,
                      ),
        
                    Text(
                      text,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        fontSize: 17.sp,
                      ),
                    ),
        
                    if (suffixicon != null) ...[
                      HorizontalSpacing(8),
                      Icon(
                        suffixicon,
                        color: context.colors.textPrimary,
                        size: 20.sp,
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
