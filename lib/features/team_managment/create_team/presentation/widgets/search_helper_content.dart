import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class SearchHelperContent extends StatelessWidget {
  const SearchHelperContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.person_add_alt_1_sharp,
          size: AppSpacing.fontSize90,
          color: context.colors.primary,
        ),
        VerticalSpacing(AppSpacing.height10),
        Text(
          CreateTeamStrings.findColleagues,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
