import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'team_type_card.dart';

class TeamTypeSelector extends StatelessWidget {
  const TeamTypeSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.teamType,
          style: AppTextStyles.titleLarge.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing8),
        TeamTypeCard(
          icon: Icons.lock_rounded,
          title: AppStrings.private,
          subtitle: AppStrings.privateDesc,
          isSelected: selectedIndex == 0,
          onTap: () => onChanged(0),
        ),
        VerticalSpacing(AppSpacing.spacing8),
        TeamTypeCard(
          icon: Icons.public_rounded,
          title: AppStrings.public,
          subtitle: AppStrings.publicDesc,
          isSelected: selectedIndex == 1,
          onTap: () => onChanged(1),
        ),
      ],
    );
  }
}
