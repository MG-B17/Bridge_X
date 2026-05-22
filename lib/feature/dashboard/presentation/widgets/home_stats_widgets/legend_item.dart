import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  const LegendItem({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSpacing.width10,
          height: AppSpacing.width10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        HorizontalSpacing(AppSpacing.sm),
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textSecondary),
          ),
        ),
      ],
    );
  }
}
