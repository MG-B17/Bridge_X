import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_settings_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/team_settings/team_settings_bloc.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/team_settings/team_settings_event.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/team_settings/team_settings_state.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/team_setting_widget/team_settings_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamSettingsScreen extends StatelessWidget {
  const TeamSettingsScreen({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeamSettingsBloc>(
      create: (_) =>
          sl<TeamSettingsBloc>()..add(LoadTeamSettings(projectId)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<TeamSettingsBloc, TeamSettingsState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is TeamSettingsFailure) {
                return BridgeXErrorWidget(
                  errorTittle: AppStrings.error,
                  errorMessage: state.message,
                  refreshButtonTap: () =>
                      context.read<TeamSettingsBloc>().add(LoadTeamSettings(projectId)),
                );
              }

              final isLoading =
                  state is TeamSettingsInitial ||
                  state is TeamSettingsLoading;

              return BridgeXRefreshIndicator(
                onRefresh: () async =>
                    context.read<TeamSettingsBloc>().add(RefreshTeamSettings(projectId)),
                color: context.colors.primary,
                child: BridgeXSkeletonizer(
                  enableloading: isLoading,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing20,
                      vertical: AppSpacing.spacing16,
                    ),
                    child: TeamSettingsContent(
                      teamSettings: _resolveTeamSettings(state),
                      projectId: projectId,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  TeamSettingsEntity _resolveTeamSettings(TeamSettingsState state) {
    return switch (state) {
      TeamSettingsLoaded(:final teamSettings) => teamSettings,
      _ => const TeamSettingsEntity(
        teamName: '',
        githubLink: '',
        projectDescription: '',
        members: [],
      ),
    };
  }
}
