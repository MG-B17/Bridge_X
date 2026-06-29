import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/entity/programmer_search_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MemberSearchResultItem extends StatelessWidget {
  const MemberSearchResultItem({
    super.key,
    required this.programmer,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

  final ProgrammerSearchEntity programmer;
  final bool isSelected;
  final VoidCallback onTap;
  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = programmer.avatarUrl?.trim();
    final hasAvatar = avatarUrl != null && avatarUrl.isNotEmpty;

    final usernameText = programmer.userName != null && programmer.userName!.isNotEmpty
        ? '@${programmer.userName}'
        : '';
    final trackText = programmer.track ?? '';
    final subtitleText = [
      if (usernameText.isNotEmpty) usernameText,
      if (trackText.isNotEmpty) trackText,
    ].join(' • ');

    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSpacing.spacing4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
        color: isSelected ? colors.primary.withValues(alpha: 0.04) : Colors.transparent,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing8,
            vertical: AppSpacing.spacing4,
          ),
          onTap: onTap,
          leading: CircleAvatar(
            radius: AppSpacing.radius22,
            backgroundColor: colors.primaryLight.withValues(alpha: 0.5),
            backgroundImage: hasAvatar ? CachedNetworkImageProvider(avatarUrl) : null,
            child: hasAvatar
                ? null
                : Text(
                    programmer.fullName.isNotEmpty ? programmer.fullName[0].toUpperCase() : '?',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          title: Text(
            programmer.fullName,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: subtitleText.isNotEmpty
              ? Text(
                  subtitleText,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colors.textSecondary,
                  ),
                )
              : null,
          trailing: Container(
            width: AppSpacing.spacing24,
            height: AppSpacing.spacing24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? colors.textPrimary : Colors.transparent,
              border: Border.all(
                color: isSelected ? colors.textPrimary : colors.textSecondary.withValues(alpha: 0.4),
                width: AppSpacing.borderWidth2,
              ),
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: colors.surface,
                    size: AppSpacing.spacing14,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
