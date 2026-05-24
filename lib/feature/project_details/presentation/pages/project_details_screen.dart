import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/project_details/domain/entities/project_details_entity.dart';
import 'package:bridge_x/feature/project_details/presentation/cubit/project_details_cubit.dart';
import 'package:bridge_x/feature/project_details/presentation/cubit/project_details_state.dart';
import 'package:bridge_x/feature/project_details/presentation/widgets/project_details_back_header.dart';
import 'package:bridge_x/feature/project_details/presentation/widgets/project_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({
    super.key,
    required this.projectId,
    required this.status,
  });

  final int projectId;
  final String status;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectDetailsCubit>(
      create: (_) => sl<ProjectDetailsCubit>(),
      child: _ProjectDetailsParamListener(
        projectId: projectId,
        status: status,
        child: const _ProjectDetailsScreenContent(),
      ),
    );
  }
}

/// Calls [ProjectDetailsCubit.loadProjectDetails] on mount and when route args change.
/// Keeps the same cubit instance — no dispose/recreate on new id or status.
class _ProjectDetailsParamListener extends StatefulWidget {
  const _ProjectDetailsParamListener({
    required this.projectId,
    required this.status,
    required this.child,
  });

  final int projectId;
  final String status;
  final Widget child;

  @override
  State<_ProjectDetailsParamListener> createState() =>
      _ProjectDetailsParamListenerState();
}

class _ProjectDetailsParamListenerState extends State<_ProjectDetailsParamListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void didUpdateWidget(covariant _ProjectDetailsParamListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.projectId != widget.projectId ||
        oldWidget.status != widget.status) {
      _load();
    }
  }

  void _load() {
    context.read<ProjectDetailsCubit>().loadProjectDetails(
          projectId: widget.projectId,
          status: widget.status,
        );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _ProjectDetailsScreenContent extends StatelessWidget {
  const _ProjectDetailsScreenContent();

  ProjectDetailsEntity _resolveProject(ProjectDetailsState state) {
    return switch (state) {
      ProjectDetailsLoaded(:final data) => data,
      ProjectDetailsRefreshing(:final data) => data,
      ProjectDetailsLoading(:final placeholderData) =>
        placeholderData ?? ProjectDetailsCubit.skeletonPlaceholder,
      ProjectDetailsInitial() => ProjectDetailsCubit.skeletonPlaceholder,
      _ => ProjectDetailsCubit.skeletonPlaceholder,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
          buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            if (state is ProjectDetailsFailure) {
              return BridgeXErrorWidget(
                errorTittle: AppStrings.error,
                errorMessage: state.errorMessage,
                refreshButtonTap: () => context.read<ProjectDetailsCubit>().retry(),
              );
            }

            final isLoading =
                state is ProjectDetailsLoading || state is ProjectDetailsInitial;
            final isRefreshing = state is ProjectDetailsRefreshing;
            final showSkeleton = isLoading || isRefreshing;

            return BridgeXSkeletonizer(
              enableloading: showSkeleton,
              child: BridgeXRefreshIndicator(
                color: isRefreshing ? context.appColors.transparent : context.appColors.primary,
                backgroundColor: isRefreshing ? context.appColors.transparent : null,
                onRefresh: () => context.read<ProjectDetailsCubit>().refreshProjectDetails(),
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
                      BlocSelector<ProjectDetailsCubit, ProjectDetailsState, ProjectDetailsEntity>(
                        selector: (state) => _resolveProject(state),
                        builder: (context, project) {
                          return ProjectDetailsContent(project: project);
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
