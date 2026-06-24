import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/app_validation_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/auth/presentation/controller/password_reset/password_reset_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/password_reset/password_reset_state.dart';
import 'package:bridge_x/features/auth/utils/auth_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordForm extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordForm({super.key, required this.email, required this.code});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<PasswordResetCubit, PasswordResetState>(
            buildWhen: (p, c) => p.isPasswordVisible != c.isPasswordVisible,
            builder: (context, state) => BridgeXTextFormField(
              label: AppStrings.newPassword.toUpperCase(),
              hint: AuthStrings.passwordDots,
              controller: _newPasswordController,
              obscureText: !state.isPasswordVisible,
              prefixIcon: Icons.vpn_key_outlined,
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => context.read<PasswordResetCubit>().togglePasswordVisibility(),
              ),
              validator: AppValidator.password,
            ),
          ),
          VerticalSpacing(AppSpacing.lg),
          BlocBuilder<PasswordResetCubit, PasswordResetState>(
            buildWhen: (p, c) => p.isConfirmPasswordVisible != c.isConfirmPasswordVisible,
            builder: (context, state) => BridgeXTextFormField(
              label: AppStrings.confirmNewPassword.toUpperCase(),
              hint: AuthStrings.passwordDots,
              controller: _confirmPasswordController,
              obscureText: !state.isConfirmPasswordVisible,
              prefixIcon: Icons.shield_outlined,
              suffixIcon: IconButton(
                icon: Icon(
                  state.isConfirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => context.read<PasswordResetCubit>().toggleConfirmPasswordVisibility(),
              ),
              validator: (val) => AppValidator.confirmPassword(_newPasswordController.text)(val),
            ),
          ),
          VerticalSpacing(AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: colors.textSecondary, size: AppSpacing.fontSize16),
              HorizontalSpacing(AppSpacing.xs),
              Expanded(
                child: Text(
                  AppValidationMessages.passwordMinLength,
                  style: text.bodySmall?.copyWith(color: colors.textSecondary),
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.xl),
          BlocConsumer<PasswordResetCubit, PasswordResetState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            buildWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                BridgeXSnackBar.showSuccess(
                  context: context,
                  message: state.message ?? AppFeedbackMessages.passwordResetSuccess,
                );
                context.goNamed(BridgeXRouteNames.login);
              } else if (state.status == AuthStatus.error) {
                ErrorDialog.show(
                  context: context,
                  title: AppStrings.requestFailed,
                  message: state.message ?? AppFeedbackMessages.genericError,
                );
              }
            },
            builder: (context, state) {
              final isLoading = state.status == AuthStatus.loading;
              return BridgeXButton(
                text: AppStrings.updatePassword,
                isLoading: isLoading,
                onTap: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<PasswordResetCubit>().resetPassword(
                            email: widget.email,
                            resetToken: widget.code,
                            newPassword: _newPasswordController.text,
                            passwordConfirmation: _confirmPasswordController.text,
                          );
                        }
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}
