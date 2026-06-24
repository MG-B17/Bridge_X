import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvitedMembersChips extends StatelessWidget {
  const InvitedMembersChips({super.key, required this.invitedMembers});

  final List<String> invitedMembers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacing(AppSpacing.spacing8),
        Wrap(
          spacing: AppSpacing.spacing8,
          runSpacing: AppSpacing.spacing4,
          children: invitedMembers.map((username) {
            return Chip(
              label: Text(
                username.startsWith('@') ? username : '@$username',
                style: TextStyle(fontSize: AppSpacing.fontSize13),
              ),
              deleteIcon: Icon(Icons.close, size: AppSpacing.fontSize16),
              onDeleted: () => context
                  .read<CreateTeamCubit>()
                  .removeInvitedMember(username),
            );
          }).toList(),
        ),
      ],
    );
  }
}
