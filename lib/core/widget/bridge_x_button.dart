import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BridgeXButton extends StatelessWidget {
  const BridgeXButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool isLoading;


  static const _gradient = LinearGradient(
    colors: [
      Color(0xFF002753), // deep navy
      Color(0xFF043A78), // mid navy
      Color(0xFF1E94DE), // bright blue
    ],
    stops: [0.0, 0.35, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const _shadowColor = Color(0xFF1E94DE);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Opacity(
        opacity: (isLoading || onTap == null) ? 0.65 : 1.0,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
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
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        fontSize: 17.sp,
                      ),
                    ),
                    HorizontalSpacing(8.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}