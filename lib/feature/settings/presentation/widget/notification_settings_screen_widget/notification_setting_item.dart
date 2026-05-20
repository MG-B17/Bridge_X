import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

class NotificationSettingItem extends StatelessWidget {
  const NotificationSettingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
    this.iconBgColor,
    this.iconColor,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? iconBgColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing20,
        vertical: AppSpacing.spacing16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppSpacing.iconBoxSize,
            height: AppSpacing.iconBoxSize,
            decoration: BoxDecoration(
              color: iconBgColor ?? context.colors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radius8),
            ),
            child: Icon(
              icon,
              color: iconColor ?? context.colors.indigo,
              size: AppSpacing.fontSize24,
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                VerticalSpacing(AppSpacing.height4),
                Text(
                  subtitle,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          HorizontalSpacing(AppSpacing.spacing8),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: context.colors.indigo,
            activeTrackColor: context.colors.indigo.withValues(alpha: 0.2),
            inactiveThumbColor: context.colors.surface,
            inactiveTrackColor: context.colors.textHint.withValues(alpha: 0.2),
            trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) => context.colors.surface.withValues(alpha: 0)),
            thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Icon(Icons.check, color: context.colors.surface);
              }
              return null;
            }),
          ),
        ],
      ),
    );
  }
}
