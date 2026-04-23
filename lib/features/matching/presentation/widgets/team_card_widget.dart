import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';
import 'member_avatars_widget.dart';
import 'tag_widget.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.colors.divider, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(context.spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (status != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      margin: EdgeInsets.only(bottom: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF2E9),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: const Color(0xFFF3E5D8), width: 1.w),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time_filled, color: const Color(0xFF935A24), size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            status!,
                            style: context.labelSmall.copyWith(
                              color: const Color(0xFF935A24),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: logoColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            logoText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: context.titleLarge.copyWith(
                                color: context.colors.textPrimary,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              category,
                              style: context.bodyMedium.copyWith(
                                color: context.colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    description,
                    style: context.bodyMedium.copyWith(
                      color: context.colors.textPrimary.withValues(alpha: 0.8),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: tags.map((tag) => TagWidget(label: tag)).toList(),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: context.colors.divider),
            Padding(
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppStrings.requestToJoin,
                      style: context.labelSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
