import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';
import 'package:bridge_x/feature/report/presentation/controller/report_cubit.dart';
import 'package:bridge_x/feature/report/presentation/controller/report_state.dart';
import 'package:bridge_x/feature/report/presentation/widget/report_actions.dart';
import 'package:bridge_x/feature/report/presentation/widget/report_description_field.dart';
import 'package:bridge_x/feature/report/presentation/widget/report_header.dart';
import 'package:bridge_x/feature/report/presentation/widget/report_reason_tile.dart';
import 'package:bridge_x/feature/report/presentation/widget/report_user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportUserScreen extends StatefulWidget {
  final int userId;

  const ReportUserScreen({super.key, required this.userId});

  @override
  State<ReportUserScreen> createState() => _ReportUserScreenState();
}

class _ReportUserScreenState extends State<ReportUserScreen> {
  static const _reasons = [
    AppStrings.notContributing,
    AppStrings.missedDeadlines,
    AppStrings.inappropriateBehavior,
    AppStrings.spamOrIrrelevantMessages,
    AppStrings.other,
  ];

  String? _selectedReason;
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String _buildDescription() {
    final text = _descriptionController.text.trim();
    if (_selectedReason == AppStrings.other) return text;
    if (text.isNotEmpty) return '$_selectedReason: $text';
    return _selectedReason!;
  }

  bool get _canSubmit {
    if (_selectedReason == null) return false;
    if (_selectedReason == AppStrings.other && _descriptionController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportCubit>(
      create: (_) => sl<ReportCubit>()..fetchUserInfo(widget.userId),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        body: SafeArea(
          child: BlocConsumer<ReportCubit, ReportState>(
            listener: (context, state) {
              if (state is ReportSubmitted) {
                BridgeXSnackBar.showSuccess(
                  context: context,
                  message: AppStrings.reportSubmittedSuccess,
                );
                if (context.mounted) context.pop();
              }
              if (state is ReportSubmitError) {
                BridgeXSnackBar.showError(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is ReportUserInfoLoading || state is ReportInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReportError) {
                return BridgeXErrorWidget(
                  errorTittle: AppStrings.failedToLoadUser,
                  errorMessage: state.message,
                  refreshButtonTap: () => context.read<ReportCubit>().fetchUserInfo(widget.userId),
                );
              }

              final userInfo = _getUserInfo(state);
              if (userInfo == null) return const SizedBox.shrink();
              final isSubmitting = state is ReportSubmitting;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing20,
                  vertical: AppSpacing.spacing16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportHeader(onClose: () => context.pop()),
                    VerticalSpacing(AppSpacing.spacing16),
                    ReportUserInfoCard(userInfo: userInfo),
                    VerticalSpacing(AppSpacing.spacing20),
                    Text(
                      AppStrings.selectAReason,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    VerticalSpacing(AppSpacing.spacing12),
                    ..._reasons.map((reason) => ReportReasonTile(
                          reason: reason,
                          isSelected: _selectedReason == reason,
                          onTap: () => setState(() => _selectedReason = reason),
                        )),
                    if (_selectedReason != null) ...[
                      VerticalSpacing(AppSpacing.spacing16),
                      ReportDescriptionField(
                        controller: _descriptionController,
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                    VerticalSpacing(AppSpacing.spacing24),
                    ReportActions(
                      canSubmit: _canSubmit,
                      isSubmitting: isSubmitting,
                      onSubmit: () {
                        context.read<ReportCubit>().submitReport(
                              targetUserId: userInfo.id,
                              description: _buildDescription(),
                            );
                      },
                      onCancel: () => context.pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ReportedUserInfoEntity? _getUserInfo(ReportState state) {
    if (state is ReportUserInfoLoaded) return state.userInfo;
    if (state is ReportSubmitting) return state.userInfo;
    if (state is ReportSubmitError) return state.userInfo;
    return null;
  }
}
