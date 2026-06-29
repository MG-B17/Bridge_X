import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

const Color _shimmerBase = Color(0xFFE0E0E0);
const Color _shimmerHighlight = Color(0xFFF5F5F5);

class TaskDetailsSkeleton extends StatelessWidget {
  const TaskDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: _shimmerBase,
        highlightColor: _shimmerHighlight,
        duration: Duration(milliseconds: 1200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkeletonHeaderCard(),
          VerticalSpacing(AppSpacing.lg),
          const _SkeletonField(label: 'DESCRIPTION', lines: 3),
          VerticalSpacing(AppSpacing.lg),
          const _SkeletonField(label: 'DUE DATE', lines: 1),
          VerticalSpacing(AppSpacing.lg),
          const _SkeletonFieldWithAvatar(label: 'CREATED BY'),
          VerticalSpacing(AppSpacing.lg),
          const _SkeletonAttachments(),
        ],
      ),
    );
  }
}

class _SkeletonHeaderCard extends StatelessWidget {
  const _SkeletonHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _SkeletonTag(),
              SizedBox(width: AppSpacing.spacing4),
              const _SkeletonTag(),
            ],
          ),
          VerticalSpacing(AppSpacing.spacing16),
          const Text('Project Name Placeholder'),
          VerticalSpacing(AppSpacing.spacing4),
          const Text('Task Title Placeholder That Is Longer'),
        ],
      ),
    );
  }
}

class _SkeletonTag extends StatelessWidget {
  const _SkeletonTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing10,
        vertical: AppSpacing.spacing4,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius32),
      ),
      child: const Text('TAG'),
    );
  }
}

class _SkeletonField extends StatelessWidget {
  const _SkeletonField({required this.label, required this.lines});

  final String label;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.spacing8, left: 4),
          child: Text(label),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.spacing16),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radius12),
            border: Border.all(color: context.colors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              lines,
              (i) => Padding(
                padding: EdgeInsets.only(top: i > 0 ? 8 : 0),
                child: const Text(
                  'Content line placeholder that is long enough for skeleton',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkeletonFieldWithAvatar extends StatelessWidget {
  const _SkeletonFieldWithAvatar({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.spacing8, left: 4),
          child: Text(label),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.spacing16),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radius12),
            border: Border.all(color: context.colors.divider),
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 16.r),
              SizedBox(width: AppSpacing.sm),
              const Text('User Name Placeholder'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkeletonAttachments extends StatelessWidget {
  const _SkeletonAttachments();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8, left: 4),
          child: const Text('ATTACHMENTS'),
        ),
        const _SkeletonAttachmentItem(),
        VerticalSpacing(AppSpacing.sm),
        const _SkeletonAttachmentItem(),
      ],
    );
  }
}

class _SkeletonAttachmentItem extends StatelessWidget {
  const _SkeletonAttachmentItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
            ),
            child: Icon(Icons.picture_as_pdf, size: 24.sp),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('File name placeholder.pdf'),
                const SizedBox(height: 4),
                const Text('Size \u2022 Added date'),
              ],
            ),
          ),
          const Icon(Icons.download_outlined),
        ],
      ),
    );
  }
}
