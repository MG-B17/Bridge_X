import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignToSection extends StatelessWidget {
  const AssignToSection({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildLabel(context, AppStrings.assignTo, isRequired: true),
            const Spacer(),
            Text(AppStrings.viewAll, style: AppTextStyles.labelSmall.copyWith(color: colors.secondary, fontWeight: FontWeight.w600)),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(hint: AppStrings.searchTeamMembers, controller: searchController, prefixIcon: Icons.search),
        VerticalSpacing(AppSpacing.spacing12),
        BlocSelector<CreateTaskCubit, CreateTaskState, _MembersData>(
          selector: (state) {
            if (state is CreateTaskReady) return _MembersData(state.members, state.selectedMemberId);
            return const _MembersData([], null);
          },
          builder: (context, data) {
            return SizedBox(
              height: AppSpacing.spacing75,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.members.length + 1,
                separatorBuilder: (context, index) => HorizontalSpacing(AppSpacing.spacing16),
                itemBuilder: (context, index) {
                  if (index == data.members.length) return _buildAddButton(context);
                  return _buildMemberAvatar(context, data.members[index], isSelected: data.selectedId == data.members[index].programmerId);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMemberAvatar(BuildContext context, TeamMemberEntity member, {required bool isSelected}) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => context.read<CreateTaskCubit>().selectMember(member.programmerId),
      child: SizedBox(
        width: 60.w,
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: colors.divider,
                  backgroundImage: member.avatarUrl != null ? NetworkImage(member.avatarUrl!) : null,
                  child: member.avatarUrl == null ? Icon(Icons.person, size: 24.sp, color: colors.textHint) : null,
                ),
                if (isSelected)
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 18.w, height: 18.w,
                      decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle, border: Border.all(color: colors.surface, width: 2)),
                      child: Icon(Icons.check, size: 10.sp, color: colors.surface),
                    ),
                  ),
              ],
            ),
            VerticalSpacing(AppSpacing.spacing4),
            Text(
              _shortenName(member.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSmall.copyWith(color: isSelected ? colors.primary : colors.textSecondary, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          CircleAvatar(radius: 24.r, backgroundColor: colors.primary.withValues(alpha: 0.1), child: Icon(Icons.add, size: 24.sp, color: colors.primary)),
          VerticalSpacing(AppSpacing.spacing4),
          Text(AppStrings.add, style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text, {bool isRequired = false}) {
    final colors = context.colors;
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.titleMedium.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
        children: isRequired ? [TextSpan(text: ' *', style: AppTextStyles.titleMedium.copyWith(color: colors.error))] : null,
      ),
    );
  }

  String _shortenName(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) return '${parts[0]} ${parts[1][0]}.';
    return name;
  }
}

class _MembersData {
  final List<TeamMemberEntity> members;
  final int? selectedId;
  const _MembersData(this.members, this.selectedId);
}
