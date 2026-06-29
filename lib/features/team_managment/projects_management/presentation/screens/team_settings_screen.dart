import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/team_settings_content.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/team_setting_widget/team_settings_shimmer.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TeamSettingsScreen extends StatefulWidget {
  const TeamSettingsScreen({super.key, required this.teamID});

  final int teamID;

  @override
  State<TeamSettingsScreen> createState() => _TeamSettingsScreenState();
}

class _TeamSettingsScreenState extends State<TeamSettingsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProjectsFeatureBloc>()
        .add(TeamSettingsOpened(widget.teamID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsFeatureBloc, ProjectsFeatureState>(
      listenWhen: (previous, current) {
        final submitChanged =
            previous.submitProject.status != current.submitProject.status;
        final tsError = current.teamSettings.errorMessage != null &&
            previous.teamSettings.errorMessage == null;
        return submitChanged || tsError;
      },
      listener: (context, state) {
        if (state.submitProject.status == FeatureActionStatus.success) {
          BridgeXSnackBar.showSuccess(
            context: context,
            message: state.submitProject.message ?? ProjectStrings.projectCompletionSubmitted,
          );
          context.pop();
        } else if (state.submitProject.status == FeatureActionStatus.failure) {
          BridgeXSnackBar.showError(
            context: context,
            message: state.submitProject.message ?? AppStrings.error,
          );
        }
        if (state.teamSettings.errorMessage != null &&
            state.teamSettings.status == ScreenDataStatus.failure) {
          BridgeXSnackBar.showError(
            context: context,
            message: state.teamSettings.errorMessage!,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.teamSettings != current.teamSettings,
      builder: (context, state) {
        final ts = state.teamSettings;
        final entity = ts.data;
        final isLoading = ts.status == ScreenDataStatus.loading ||
            ts.status == ScreenDataStatus.initial;
        final isFullFailure =
            ts.status == ScreenDataStatus.failure && entity == null;

        if (isFullFailure) {
          return Scaffold(
            body: SafeArea(
              child: BridgeXErrorWidget(
                errorTittle: AppStrings.error,
                errorMessage: ts.errorMessage ?? '',
                refreshButtonTap: () =>
                    context.read<ProjectsFeatureBloc>().add(
                      TeamSettingsOpened(widget.teamID),
                    ),
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: BridgeXRefreshIndicator(
              onRefresh: () async =>
                  context.read<ProjectsFeatureBloc>().add(
                    const TeamSettingsRefreshRequested(),
                  ),
              color: context.colors.primary,
              child: BridgeXSkeletonizer(
                enableloading: isLoading || entity == null,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing20,
                    vertical: AppSpacing.spacing16,
                  ),
                  child: entity != null
                      ? TeamSettingsContent(teamSettings: entity)
                      : const TeamSettingsShimmer(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
