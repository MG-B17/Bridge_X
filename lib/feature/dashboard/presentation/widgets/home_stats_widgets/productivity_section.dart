import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'productivity_chart.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key, this.completionRate});

  final double? completionRate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.yourProductivity,
          style: AppTextStyles.headlineSmall.copyWith(color: context.colors.textPrimary),
        ),
        VerticalSpacing(AppSpacing.spacing16),
        ProductivityChart(completionRate: completionRate),
      ],
    );
  }
}
