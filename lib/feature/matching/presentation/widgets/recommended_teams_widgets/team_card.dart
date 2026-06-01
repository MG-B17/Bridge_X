import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';


class TeamCard extends StatelessWidget {
  const TeamCard({
    super.key,
    required this.initials,
    required this.name,
    required this.category,
    required this.description,
    required this.tags,
    required this.currentMembers,
    required this.maxMembers,
    this.avatarColor,
    this.onRequestJoin,
  });

  final String initials;
  final String name;
  final String category;
  final String description;
  final List<String> tags;
  final int currentMembers;
  final int maxMembers;
  final Color? avatarColor;
  final VoidCallback? onRequestJoin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius20),
        border: Border.all(color: colors.divider.withValues(alpha: 0.3)),
        boxShadow: AppShadow.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSpacing.spacing42,
                height: AppSpacing.spacing42,
                decoration: BoxDecoration(
                  color: avatarColor ?? colors.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.radius6),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              HorizontalSpacing(AppSpacing.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    VerticalSpacing(AppSpacing.spacing4),
                    Text(
                      category,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing8),
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.textSecondary,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          VerticalSpacing(AppSpacing.spacing8),
          Wrap(
            spacing: AppSpacing.spacing6,
            runSpacing: AppSpacing.height6,
            children: tags.map((tag) => _TagChip(label: tag)).toList(),
          ),
          VerticalSpacing(AppSpacing.spacing16),
          Row(
            children: [
              _MiniAvatarStack(count: currentMembers),
              HorizontalSpacing(AppSpacing.spacing8),
              Text(
                '$currentMembers/$maxMembers ${AppStrings.membersLabel}',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onRequestJoin,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing14,
                    vertical: AppSpacing.height8,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColorScheme.gradient,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radius30),
                  ),
                  child: Text(
                    AppStrings.requestToJoin,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing10,
        vertical: AppSpacing.height5,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radius30),
        border: Border.all(
          color: colors.divider.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: AppSpacing.fontSize11,
        ),
      ),
    );
  }
}

class _MiniAvatarStack extends StatelessWidget {
  const _MiniAvatarStack({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final themeColors = [
      colors.primary,
      colors.amber,
      colors.teal,
    ];

    final visible = count.clamp(0, 3);
    final overflow = count - visible;
    final size = AppSpacing.spacing24;

    return SizedBox(
      height: size,
      width: (size * 0.65) * visible + (overflow > 0 ? AppSpacing.spacing18 : 0),
      child: Stack(
        children: [
          ...List.generate(visible, (i) {
            return Positioned(
              left: i * size * 0.55,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: themeColors[i % themeColors.length],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context)
                        .extension<AppColorScheme>()!
                        .surface,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: AppSpacing.fontSize12,
                ),
              ),
            );
          }),
          if (overflow > 0)
            Positioned(
              left: visible * size * 0.55,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colors.textPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context)
                        .extension<AppColorScheme>()!
                        .surface,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$overflow',
                    style: TextStyle(
                      color: colors.surface,
                      fontSize: AppSpacing.fontSize8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
