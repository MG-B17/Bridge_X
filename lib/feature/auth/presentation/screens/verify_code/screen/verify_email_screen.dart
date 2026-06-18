import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/sub_title_text.dart';
import 'package:bridge_x/feature/auth/presentation/controller/verification/verification_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/verification/verification_state.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verify_code/widget/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailScreen extends StatelessWidget {
  final OtpArgs otpArgs;

  const VerifyEmailScreen({super.key, required this.otpArgs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationCubit>(
      create: (_) => sl<VerificationCubit>(),
      child: BlocConsumer<VerificationCubit, VerificationState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            BridgeXSnackBar.showSuccess(
              context: context,
              message: state.message ?? AppFeedbackMessages.verificationSuccess,
            );
            context.goNamed(BridgeXRouteNames.login);
          } else if (state.status == AuthStatus.error) {
            ErrorDialog.show(
              context: context,
              title: AppStrings.verificationFailed,
              message: state.message ?? AppFeedbackMessages.invalidOtpMessage,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(AppSpacing.xxl),
                    const ScreenNameText(text: AppStrings.verifyCode),
                    VerticalSpacing(AppSpacing.lg),
                    const SubTitleText(text: AppStrings.verifyDescription),
                    VerticalSpacing(AppSpacing.xxl),
                    OtpForm(
                      email: otpArgs.email,
                      verifyAction: AuthAction.verifyEmail,
                      isLoading: state.status == AuthStatus.loading,
                      onVerify: (code) {
                        context.read<VerificationCubit>().verifyEmail(
                          email: otpArgs.email,
                          code: code,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
