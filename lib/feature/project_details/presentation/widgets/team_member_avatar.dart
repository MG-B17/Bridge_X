import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/project_details/domain/entities/team_member_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamMemberAvatar extends StatelessWidget {
  const TeamMemberAvatar({super.key, required this.member});

  final TeamMemberEntity member;

  static String firstName(String fullName) {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final avatarUrl = member.avatarUrl?.trim();
    final hasAvatar = avatarUrl != null && avatarUrl.isNotEmpty;

    return SizedBox(
      width: 72.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.surface, width: 2.w),
            ),
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: colors.primaryLight.withValues(alpha: 0.35),
              backgroundImage: hasAvatar ? NetworkImage(avatarUrl) : null,
              child: hasAvatar
                  ? null
                  : Icon(
                      Icons.person,
                      color: colors.secondary,
                      size: 28.sp,
                    ),
            ),
          ),
          VerticalSpacing(AppSpacing.xs),
          Text(
            firstName(member.name),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
