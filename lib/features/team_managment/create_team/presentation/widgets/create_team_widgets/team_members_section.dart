import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_cubit.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_state.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/invited_members_chips.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_search_bottom_sheet.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamMembersSection extends StatelessWidget {
  const TeamMembersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<CreateTeamCubit, CreateTeamState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CreateTeamStrings.teamMembers,
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            VerticalSpacing(AppSpacing.spacing4),
            Text(
              CreateTeamStrings.inviteMembersManually,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary,
              ),
            ),
            if (state.invitedMembers.isNotEmpty)
              InvitedMembersChips(invitedMembers: state.invitedMembers),
            VerticalSpacing(AppSpacing.spacing8),
            BridgeXOutlineButton(
              text: CreateTeamStrings.addMembers,
              prefixicon: Icons.group_add_outlined,
              onTap: () => _showAddMemberSheet(context),
            ),
          ],
        );
      },
    );
  }

  void _showAddMemberSheet(BuildContext context) {
    final cubit = context.read<CreateTeamCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const MemberSearchBottomSheet(),
      ),
    );
  }
}
