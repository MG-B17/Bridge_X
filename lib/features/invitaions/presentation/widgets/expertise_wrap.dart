import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class ExpertiseWrap extends StatelessWidget {
  final List<String> tags;

  const ExpertiseWrap({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.spacing8,
      runSpacing: AppSpacing.spacing8,
      children: tags.map((tag) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing12,
            vertical: AppSpacing.spacing6,
          ),
          decoration: BoxDecoration(
            color: context.appColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.radius6),
          ),
          child: Text(
            tag,
            style: AppTextStyles.labelSmall.copyWith(
              color: context.appColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}
