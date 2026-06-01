import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/details/completed_project_details_entity.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/completed_project_details/completed_project_details_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/completed_project_details/completed_project_details_state.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/completed_project_details_content.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/details_screen_widgets/project_details_back_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedProjectDetailsScreen extends StatelessWidget {
  const CompletedProjectDetailsScreen({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompletedProjectDetailsCubit>(
      create: (_) => sl<CompletedProjectDetailsCubit>()..load(projectId),
      child: const _ScreenContent(),
    );
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent();

  static const CompletedProjectDetailsEntity _placeholder =
      CompletedProjectDetailsEntity(
    id: 0,
    title: '',
    description: '',
    status: 'completed',
    myTrack: '',
    teamMembers: [],
    category: '',
    durationDays: 0,
    completionDate: '',
    feedbacks: [],
    myRating: 0,
    starsPercentage: 0,
    impacts: [],
  );

  CompletedProjectDetailsEntity _resolveProject(
    CompletedProjectDetailsState state,
  ) =>
      switch (state) {
        CompletedProjectDetailsLoaded(:final data) => data,
        CompletedProjectDetailsRefreshing(:final data) => data,
        CompletedProjectDetailsLoading(:final placeholderData) =>
          placeholderData ?? _placeholder,
        _ => _placeholder,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CompletedProjectDetailsCubit,
            CompletedProjectDetailsState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is CompletedProjectDetailsFailure) {
              return BridgeXErrorWidget(
                errorTittle: AppStrings.error,
                errorMessage: state.errorMessage,
                refreshButtonTap: () =>
                    context.read<CompletedProjectDetailsCubit>().retry(),
              );
            }

            final isLoading = state is CompletedProjectDetailsInitial ||
                state is CompletedProjectDetailsLoading;
            final isRefreshing = state is CompletedProjectDetailsRefreshing;
            final showSkeleton = isLoading || isRefreshing;

            return BridgeXSkeletonizer(
              enableloading: showSkeleton,
              child: BridgeXRefreshIndicator(
                color: isRefreshing
                    ? context.appColors.transparent
                    : context.appColors.primary,
                backgroundColor:
                    isRefreshing ? context.appColors.transparent : null,
                onRefresh: () async =>
                    context.read<CompletedProjectDetailsCubit>().refresh(),
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
                      BlocSelector<CompletedProjectDetailsCubit,
                          CompletedProjectDetailsState,
                          CompletedProjectDetailsEntity>(
                        selector: _resolveProject,
                        builder: (context, project) {
                          return CompletedProjectDetailsContent(
                              project: project);
                        },
                      ),
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
