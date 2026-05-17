import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A single team recommendation card.
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
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
        border: Border.all(color: colors.divider.withValues(alpha: 0.3)),
        boxShadow: AppSpacing.subtleShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar + name/category ──
          Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: avatarColor ?? colors.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
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
              HorizontalSpacing(AppSpacing.md),
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
                    VerticalSpacing(AppSpacing.xs),
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
          VerticalSpacing(AppSpacing.sm),

          // ── Description ──
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colors.textSecondary,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          VerticalSpacing(AppSpacing.sm),

          // ── Tags ──
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: tags.map((tag) => _TagChip(label: tag)).toList(),
          ),
          VerticalSpacing(AppSpacing.md),

          // ── Footer: avatars + member count + request button ──
          Row(
            children: [
              // Mini avatar stack
              _MiniAvatarStack(count: currentMembers),
              HorizontalSpacing(AppSpacing.sm),
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
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColorScheme.gradient,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusPill),
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

// ── Tag chip ────────────────────────────────────────────────────────────────
class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        border: Border.all(
          color: colors.divider.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}

// ── Mini avatar stack ───────────────────────────────────────────────────────
class _MiniAvatarStack extends StatelessWidget {
  const _MiniAvatarStack({required this.count});
  final int count;

  static const _colors = [
    Color(0xFF8B5CF6),
    Color(0xFFF59E0B),
    Color(0xFF06B6D4),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = count.clamp(0, 3);
    final overflow = count - visible;
    final size = 24.w;

    return SizedBox(
      height: size,
      width: (size * 0.65) * visible + (overflow > 0 ? 18.w : 0),
      child: Stack(
        children: [
          ...List.generate(visible, (i) {
            return Positioned(
              left: i * size * 0.55,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: _colors[i % _colors.length],
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
                  size: 12.sp,
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
                  color: const Color(0xFF1F2937),
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
                      color: Colors.white,
                      fontSize: 8.sp,
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
