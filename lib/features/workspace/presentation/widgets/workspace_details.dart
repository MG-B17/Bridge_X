import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/widgets/h_space.dart';
import 'member_avatar_widget.dart';
import 'task_item_widget.dart';

class WorkspaceBanner extends StatelessWidget {
  const WorkspaceBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        border: Border.all(color: context.colors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.spacing.xs),
            decoration: BoxDecoration(color: context.colors.primary, shape: BoxShape.circle),
            child: Icon(Icons.check, color: Colors.white, size: 16.w),
          ),
          HSpace(context.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.joinedTeam,
                  style: context.bodyMedium.copyWith(fontWeight: FontWeight.w900, color: context.colors.primary),
                ),
                Text(
                  AppStrings.startCollaboration,
                  style: context.labelSmall.copyWith(color: context.colors.primary.withValues(alpha: 0.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WorkspaceMembers extends StatelessWidget {
  const WorkspaceMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.members.toUpperCase(),
          style: context.labelSmall.copyWith(fontWeight: FontWeight.w900, color: context.colors.textPrimary, letterSpacing: 1.2),
        ),
        VSpace(context.spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            MemberAvatarWidget(name: 'Sarah J.', role: 'Lead Dev', imageUrl: 'https://i.pravatar.cc/150?u=sarah', isOnline: true),
            MemberAvatarWidget(name: 'Marcus T.', role: 'Fullstack', imageUrl: 'https://i.pravatar.cc/150?u=marcus', isOnline: true),
            MemberAvatarWidget(name: 'Elena R.', role: 'PM', imageUrl: 'https://i.pravatar.cc/150?u=elena'),
          ],
        ),
      ],
    );
  }
}

class WorkspaceTasks extends StatelessWidget {
  const WorkspaceTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.yourTasks.toUpperCase(),
              style: context.labelSmall.copyWith(fontWeight: FontWeight.w900, color: context.colors.textPrimary, letterSpacing: 1.2),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.md, vertical: context.spacing.xs),
              decoration: BoxDecoration(color: context.colors.divider.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(context.spacing.radiusPill)),
              child: Text(AppStrings.viewAllTasks, style: context.labelSmall.copyWith(color: context.colors.primary, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
        VSpace(context.spacing.md),
        const TaskItemWidget(title: 'Design Login Screen', dueDate: AppStrings.dueTomorrow, icon: Icons.edit_note_rounded, iconColor: Color(0xFF3B82F6), iconBgColor: Color(0xFFEFF6FF)),
        const TaskItemWidget(title: 'Refine Typography', dueDate: AppStrings.nextSprint, icon: Icons.format_paint_rounded, iconColor: Color(0xFF9CA3AF), iconBgColor: Color(0xFFF3F4F6)),
      ],
    );
  }
}
