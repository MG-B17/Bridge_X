import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import 'member_avatars_widget.dart';
import 'team_card_components.dart';

class TeamCardWidget extends StatelessWidget {
  final String title, category, description, membersLabel, logoText;
  final List<String> tags;
  final Color logoColor;
  final String? status;
  final VoidCallback? onTap;

  const TeamCardWidget({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.tags,
    required this.membersLabel,
    required this.logoColor,
    required this.logoText,
    this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
          border: Border.all(color: context.colors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainContent(context),
            Divider(height: 1, color: context.colors.divider),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status != null) TeamCardStatus(status: status!),
          TeamCardHeader(logoText: logoText, logoColor: logoColor, title: title, category: category),
          VSpace(context.spacing.md),
          Text(
            description,
            style: context.bodyMedium.copyWith(color: context.colors.textPrimary.withValues(alpha: 0.8), height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          VSpace(context.spacing.md),
          TeamCardTags(tags: tags),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.md, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MemberAvatarsWidget(count: 3, label: membersLabel),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.spacing.radiusCard)),
              elevation: 0,
            ),
            child: Text(
              AppStrings.requestToJoin,
              style: context.labelSmall.copyWith(fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
