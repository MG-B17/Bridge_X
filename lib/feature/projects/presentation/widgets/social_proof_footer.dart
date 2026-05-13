import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Social-proof footer showing overlapping coloured dots
/// and a "Join 5,000+ active teams today" label.
class SocialProofFooter extends StatelessWidget {
  const SocialProofFooter({super.key});

  static const _dotColors = [
    Color(0xFFB0D4F1), // light blue
    Color(0xFFA5C8E8), // mid blue
    AppColors.primaryBlue, // dark blue
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Overlapping dots ──
        SizedBox(
          width: 52.w,
          height: 24.h,
          child: Stack(
            children: List.generate(_dotColors.length, (i) {
              return Positioned(
                left: i * 14.0.w,
                child: Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    color: _dotColors[i],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.scaffoldBg,
                      width: 2,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          'Join 5,000+ active teams today',
          style: AppTextStyles.labelSmall.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
