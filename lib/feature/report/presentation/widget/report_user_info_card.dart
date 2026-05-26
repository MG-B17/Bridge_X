import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportUserInfoCard extends StatelessWidget {
  final ReportedUserInfoEntity userInfo;

  const ReportUserInfoCard({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing12),
      decoration: BoxDecoration(
        color: context.colors.textPrimary,
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSpacing.radius20,
            backgroundColor: context.colors.surface.withValues(alpha: 0.2),
            backgroundImage: userInfo.avatarUrl != null ? NetworkImage(userInfo.avatarUrl!) : null,
            child: userInfo.avatarUrl == null
                ? Icon(Icons.person, color: context.colors.surface, size: 20.w)
                : null,
          ),
          SizedBox(width: AppSpacing.spacing12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo.name,
                style: AppTextStyles.titleMedium.copyWith(
                  color: context.colors.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userInfo.track,
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.colors.surface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
