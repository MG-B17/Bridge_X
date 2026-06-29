import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/details_screen_widgets/completed_project_details_content.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/widgets/details_screen_widgets/project_details_back_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedProjectDetailsScreen extends StatefulWidget {
  const CompletedProjectDetailsScreen({super.key, required this.projectId});

  final int projectId;

  @override
  State<CompletedProjectDetailsScreen> createState() =>
      _CompletedProjectDetailsScreenState();
}

class _CompletedProjectDetailsScreenState
    extends State<CompletedProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProjectsFeatureBloc>()
        .add(CompletedProjectDetailsOpened(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProjectsFeatureBloc, ProjectsFeatureState>(
          buildWhen: (previous, current) =>
              previous.completedDetails != current.completedDetails,
          builder: (context, state) {
            final ds = state.completedDetails;
            final entity = ds.data;
            final isLoading = ds.status == ScreenDataStatus.loading ||
                ds.status == ScreenDataStatus.initial;
            final isRefreshing = ds.status == ScreenDataStatus.refreshing;
            final showSkeleton = isLoading || isRefreshing;
            final isFullFailure =
                ds.status == ScreenDataStatus.failure && entity == null;

            if (isFullFailure) {
              return BridgeXErrorWidget(
                errorTittle: AppStrings.error,
                errorMessage: ds.errorMessage ?? '',
                refreshButtonTap: () =>
                    context.read<ProjectsFeatureBloc>().add(
                      CompletedProjectDetailsOpened(widget.projectId),
                    ),
              );
            }

            return BridgeXSkeletonizer(
              enableloading: showSkeleton,
              child: BridgeXRefreshIndicator(
                color: isRefreshing
                    ? context.appColors.transparent
                    : context.appColors.primary,
                backgroundColor:
                    isRefreshing ? context.appColors.transparent : null,
                onRefresh: () async =>
                    context.read<ProjectsFeatureBloc>().add(
                      const CompletedProjectDetailsRefreshRequested(),
                    ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing20,
                    vertical: AppSpacing.spacing16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProjectDetailsBackHeader(),
                      VerticalSpacing(AppSpacing.spacing16),
                      if (entity != null)
                        CompletedProjectDetailsContent(project: entity),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
