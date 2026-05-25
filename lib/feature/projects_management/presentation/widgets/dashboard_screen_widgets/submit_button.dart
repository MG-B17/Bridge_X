import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/submit_project/submit_project_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/submit_project/submit_project_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubmitButton extends StatelessWidget {
  final int projectId;

  const SubmitButton({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubmitProjectCubit>(
      create: (_) => sl<SubmitProjectCubit>(),
      child: BlocConsumer<SubmitProjectCubit, SubmitProjectState>(
        listener: (context, state) {
          if (!context.mounted) return;

          if (state is SubmitProjectLoading) {
            LoadingDialog.show(
              context: context,
              message: 'Submitting project...',
            );
          } else if (state is SubmitProjectSuccess) {
            LoadingDialog.hide(context);
            SuccessDialog.show(
              context: context,
              title: 'Success',
              message: state.message,
              onAction: () {
                context.pop();
              },
            );
          } else if (state is SubmitProjectFailure) {
            LoadingDialog.hide(context);
            ErrorDialog.show(
              context: context,
              title: 'Error',
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is SubmitProjectLoading;
          return BridgeXButton(
            text: AppStrings.submitProject,
            onTap: isLoading
                ? null
                : () {
                    context.read<SubmitProjectCubit>().submitProject(projectId);
                  },
          );
        },
      ),
    );
  }
}
