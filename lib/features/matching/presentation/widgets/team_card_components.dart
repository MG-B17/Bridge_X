import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import 'tag_widget.dart';

class TeamCardHeader extends StatelessWidget {
  final String logoText;
  final Color logoColor;
  final String title;
  final String category;

  const TeamCardHeader({
    super.key,
    required this.logoText,
    required this.logoColor,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                style: context.titleLarge.copyWith(color: context.colors.textPrimary, fontSize: 18.sp),
              ),
              Text(
                category,
                style: context.bodyMedium.copyWith(color: context.colors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TeamCardStatus extends StatelessWidget {
  final String status;
  const TeamCardStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF2E9),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF3E5D8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time_filled, color: const Color(0xFF935A24), size: 14.w),
          SizedBox(width: 4.w),
          Text(
            status,
            style: context.labelSmall.copyWith(color: const Color(0xFF935A24), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TeamCardTags extends StatelessWidget {
  final List<String> tags;
  const TeamCardTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: tags.map((tag) => TagWidget(label: tag)).toList(),
    );
  }
}
