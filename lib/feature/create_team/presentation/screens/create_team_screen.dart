import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/enum/create_team_status_enum.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/feature/create_team/presentation/controller/create_team_cubit.dart';
import 'package:bridge_x/feature/create_team/presentation/controller/create_team_state.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/create_team_widgets/create_team_form_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  bool _isLoadingDialogShowing = false;

  void _dismissLoadingDialog() {
    if (_isLoadingDialogShowing) {
      context.pop();
      _isLoadingDialogShowing = false;
    }
  }

  void _showLoadingDialog() {
    if (!_isLoadingDialogShowing) {
      _isLoadingDialogShowing = true;
      LoadingDialog.show(context: context, message: 'Creating team...').then((_) {
        _isLoadingDialogShowing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTeamCubit>(
      create: (context) => sl<CreateTeamCubit>(),
      child: BlocListener<CreateTeamCubit, CreateTeamState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == CreateTeamStatus.loading) {
            _showLoadingDialog();
          } else if (state.status == CreateTeamStatus.failure) {
            _dismissLoadingDialog();
            ErrorDialog.show(
              context: context,
              title: AppStrings.requestFailed,
              message: state.errorMessage ?? '',
              actionLabel: AppStrings.tryAgain,
              onAction: () {
                context.read<CreateTeamCubit>().resetStatus();
              },
            );
          } else if (state.status == CreateTeamStatus.success) {
            _dismissLoadingDialog();
            SuccessDialog.show(
              context: context,
              title: AppStrings.success,
              message: AppStrings.teamCreatedSuccessfully,
              onAction: () {
                context.read<ScrollCubit>().show();
                context.pop();
              },
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: AppSpacing.spacing16,
                      right: AppSpacing.spacing16,
                      top: AppSpacing.spacing16,
                      bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
                    ),
                    child: const CreateTeamFormContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
