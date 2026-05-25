import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/team_settings_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionButtonsSection extends StatelessWidget {
  final int projectId;

  const ActionButtonsSection({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.spacing10,
      children: [
        Expanded(
          child: _buildButton(
            context,
            AppStrings.openChat,
            Icons.chat_bubble_outline,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing16),
        Expanded(
          child: _buildButton(
            onTap: () {
              context.goNamed(BridegeXRouteNames.teamSettings,extra: TeamSettingsArgs(projectId:projectId));
            },
            context,
            AppStrings.teamSettings,
            Icons.settings_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.height72 + AppSpacing.height8,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing10,
          vertical: AppSpacing.spacing8,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppSpacing.radius20),
          border: Border.all(color: context.colors.divider, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: context.colors.secondary,
              size: AppSpacing.fontSize26,
            ),
            VerticalSpacing(AppSpacing.spacing10),
            Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
