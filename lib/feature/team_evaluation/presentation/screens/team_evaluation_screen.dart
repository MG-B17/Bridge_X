import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/feature/team_evaluation/domain/entities/evaluation_member_entity.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/cubit/team_evaluation_cubit.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/cubit/team_evaluation_state.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/widgets/evaluation_header.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/widgets/evaluation_info_card.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/widgets/evaluation_member_card.dart';
import 'package:bridge_x/feature/team_evaluation/presentation/widgets/evaluation_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TeamEvaluationScreen extends StatefulWidget {
  final int teamId;

  const TeamEvaluationScreen({super.key, required this.teamId});

  @override
  State<TeamEvaluationScreen> createState() => _TeamEvaluationScreenState();
}

class _TeamEvaluationScreenState extends State<TeamEvaluationScreen> {
  final Map<int, int> _ratings = {};
  final Map<int, TextEditingController> _feedbackControllers = {};

  @override
  void dispose() {
    for (final controller in _feedbackControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getController(int memberId) {
    return _feedbackControllers.putIfAbsent(memberId, () => TextEditingController());
  }

  void _onSubmit() {
    final evaluations = <Map<String, dynamic>>[];
    for (final entry in _ratings.entries) {
      if (entry.value > 0) {
        final eval = <String, dynamic>{
          'evaluated_id': entry.key,
          'rating': entry.value,
        };
        final feedback = _feedbackControllers[entry.key]?.text.trim() ?? '';
        if (feedback.isNotEmpty) eval['feedback'] = feedback;
        evaluations.add(eval);
      }
    }
    context.read<TeamEvaluationCubit>().submitEvaluations(
          widget.teamId,
          evaluations,
        );
  }

  void _onBack() {
    context.read<ScrollCubit>().show();
    context.goNamed(BridegeXRouteNames.projects);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamEvaluationCubit, TeamEvaluationState>(
      listener: (context, state) {
        if (!context.mounted) return;
        if (state is TeamEvaluationSubmitting) {
          LoadingDialog.show(context: context, message: 'Submitting evaluations...');
        } else if (state is TeamEvaluationSubmitSuccess) {
          LoadingDialog.hide(context);
          SuccessDialog.show(
            context: context,
            title: 'Success',
            message: state.message,
            onAction: () {
              context.read<ScrollCubit>().show();
              context.goNamed(BridegeXRouteNames.projects);
            },
          );
        } else if (state is TeamEvaluationSubmitFailure) {
          LoadingDialog.hide(context);
          ErrorDialog.show(
            context: context,
            title: 'Error',
            message: state.message,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<TeamEvaluationCubit, TeamEvaluationState>(
            buildWhen: (prev, curr) =>
                curr is TeamEvaluationMembersLoading ||
                curr is TeamEvaluationMembersLoaded ||
                curr is TeamEvaluationMembersFailure,
            builder: (context, state) {
              if (state is TeamEvaluationMembersFailure) {
                return BridgeXErrorWidget(
                  errorTittle: 'Error',
                  errorMessage: state.message,
                  refreshButtonTap: () =>
                      context.read<TeamEvaluationCubit>().loadMembers(widget.teamId),
                );
              }

              final isLoading = state is TeamEvaluationMembersLoading;
              final teamName = state is TeamEvaluationMembersLoaded ? state.teamName : '';
              final members = state is TeamEvaluationMembersLoaded
                  ? state.members
                  : <EvaluationMemberEntity>[];

              return BridgeXSkeletonizer(
                enableloading: isLoading,
                child: Column(
                  children: [
                    EvaluationHeader(onBack: _onBack),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.spacing20,
                        ),
                        children: [
                          SizedBox(height: AppSpacing.spacing16),
                          EvaluationInfoCard(teamName: teamName),
                          SizedBox(height: AppSpacing.spacing16),
                          ...members.map((m) => Padding(
                                padding: EdgeInsets.only(bottom: AppSpacing.spacing16),
                                child: EvaluationMemberCard(
                                  member: m,
                                  rating: _ratings[m.programmerId] ?? 0,
                                  feedbackController: _getController(m.programmerId),
                                  onRatingChanged: (rating) => setState(() {
                                    _ratings[m.programmerId] = rating;
                                  }),
                                ),
                              )),
                          SizedBox(height: AppSpacing.spacing16),
                        ],
                      ),
                    ),
                    if (!isLoading && members.isNotEmpty)
                      EvaluationSubmitButton(onPressed: _onSubmit),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
