import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/team_evaluation_args.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_bloc.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_event.dart';
import 'package:bridge_x/features/team_managment/projects_management/presentation/bloc/projects_feature/projects_feature_state.dart';
import 'package:bridge_x/features/team_managment/utils/project_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubmitButton extends StatelessWidget {
  final int projectId;

  const SubmitButton({super.key, required this.projectId});

  void _confirmAndSubmit(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(ProjectStrings.submitProjectAsCompleted),
        content: const Text(ProjectStrings.markProjectAsCompletedDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context
                  .read<ProjectsFeatureBloc>()
                  .add(SubmitProjectConfirmed(projectId));
            },
            child: const Text(AppStrings.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectsFeatureBloc, ProjectsFeatureState>(
      listenWhen: (previous, current) =>
          previous.submitProject.status != current.submitProject.status,
      listener: (context, state) {
        if (!context.mounted) return;

        if (state.submitProject.status == FeatureActionStatus.loading) {
          LoadingDialog.show(
            context: context,
            message: 'Submitting project...',
          );
        } else if (state.submitProject.status == FeatureActionStatus.success) {
          LoadingDialog.hide(context);
          SuccessDialog.show(
            context: context,
            title: 'Success',
            message: state.submitProject.message ?? '',
            onAction: () {
              context.pushNamed(
                BridgeXRouteNames.teamEvaluation,
                extra: TeamEvaluationArgs(projectId: projectId),
              );
            },
          );
          context
              .read<ProjectsFeatureBloc>()
              .add(const ClearSubmitProjectAction());
        } else if (state.submitProject.status == FeatureActionStatus.failure) {
          LoadingDialog.hide(context);
          ErrorDialog.show(
            context: context,
            title: 'Error',
            message: state.submitProject.message ?? '',
          );
          context
              .read<ProjectsFeatureBloc>()
              .add(const ClearSubmitProjectAction());
        }
      },
      builder: (context, state) {
        final isLoading =
            state.submitProject.status == FeatureActionStatus.loading;
        return BridgeXButton(
          text: ProjectStrings.submitProject,
          onTap: isLoading ? null : () => _confirmAndSubmit(context),
        );
      },
    );
  }
}
