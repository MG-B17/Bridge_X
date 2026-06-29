import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportReasonTile extends StatelessWidget {
  final String reason;
  final bool isSelected;
  final VoidCallback onTap;

  const ReportReasonTile({
    super.key,
    required this.reason,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.spacing12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reason,
                  style: AppTextStyles.bodyLarge.copyWith(color: context.colors.textPrimary),
                ),
                Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? context.colors.primary : context.colors.divider,
                      width: isSelected ? 6 : 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: context.colors.divider.withValues(alpha: 0.5)),
      ],
    );
  }
}
