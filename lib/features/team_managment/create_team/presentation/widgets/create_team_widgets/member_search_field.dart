import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class MemberSearchField extends StatelessWidget {
  const MemberSearchField({
    super.key,
    required this.controller,
    required this.colors,
  });

  final TextEditingController controller;
  final AppColorScheme colors;

  InputDecoration _buildDecoration(AppColorScheme colors) {
    final sharedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius12),
      borderSide: BorderSide(
        color: colors.divider.withValues(alpha: 0.5),
        width: AppSpacing.borderWidth1,
      ),
    );

    return InputDecoration(
      hintText: CreateTeamStrings.searchByUsername,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: colors.textSecondary.withValues(alpha: 0.7),
      ),
      prefixIcon: Icon(
        Icons.search,
        color: colors.textSecondary.withValues(alpha: 0.8),
        size: AppSpacing.fontSize20,
      ),
      border: sharedBorder,
      enabledBorder: sharedBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
        borderSide: BorderSide(
          color: colors.primary,
          width: AppSpacing.borderWidth1_5,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: AppSpacing.spacing14,
      ),
      filled: true,
      fillColor: colors.background.withValues(alpha: 0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: _buildDecoration(colors),
      textInputAction: TextInputAction.done,
      style: AppTextStyles.bodyMedium.copyWith(
        color: colors.textPrimary,
      ),
    );
  }
}
