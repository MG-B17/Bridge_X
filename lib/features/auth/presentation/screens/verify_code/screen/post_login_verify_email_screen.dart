import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/features/auth/presentation/auth_widget/sub_title_text.dart';
import 'package:bridge_x/features/auth/presentation/controller/verification/verification_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/verification/verification_state.dart';
import 'package:bridge_x/features/auth/presentation/screens/verify_code/widget/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostLoginVerifyEmailScreen extends StatelessWidget {
  const PostLoginVerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = sl<AppState>().userData?.userEmail;
    if (email == null || email.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(AppFeedbackMessages.genericError),
        ),
      );
    }

    return BlocProvider<VerificationCubit>(
      create: (_) {
        final cubit = sl<VerificationCubit>();
        cubit.startResendCooldown();
        return cubit;
      },
      child: BlocConsumer<VerificationCubit, VerificationState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            sl<AppState>().isVerified = true;
            BridgeXSnackBar.showSuccess(
              context: context,
              message: state.message ?? AppFeedbackMessages.verificationSuccess,
            );
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
                      email: email,
                      verifyAction: AuthAction.verifyEmail,
                      isLoading: state.status == AuthStatus.loading,
                      onVerify: (code) {
                        context.read<VerificationCubit>().verifyEmail(
                          email: email,
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
