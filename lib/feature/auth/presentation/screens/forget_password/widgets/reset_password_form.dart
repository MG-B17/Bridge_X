import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/app_validation_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:bridge_x/core/navigation/bridge_x_route_constant.dart';

import 'package:bridge_x/core/widget/error_dialog.dart';

class ResetPasswordForm extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordForm({
    super.key,
    required this.email,
    required this.code,
  });

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
          BridgeXTextFormField(
            label: AppStrings.newPassword.toUpperCase(),
            hint: '••••••••',
            controller: _newPasswordController,
            obscureText: true,
            prefixIcon: Icons.vpn_key_outlined,
            validator: AppValidator.password,
          ),
          VerticalSpacing(AppSpacing.lg),
          BridgeXTextFormField(
            label: AppStrings.confirmNewPassword.toUpperCase(),
            hint: '••••••••',
            controller: _confirmPasswordController,
            obscureText: true,
            prefixIcon: Icons.shield_outlined,
            validator: (val) => AppValidator.confirmPassword(_newPasswordController.text)(val),
          ),
          VerticalSpacing(AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: colors.textSecondary,
                size: 16.sp,
              ),
              HorizontalSpacing(AppSpacing.xs),
              Expanded(
                child: Text(
                  AppValidationMessages.passwordMinLength,
                  style: text.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          VerticalSpacing(AppSpacing.xl),
          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (prev, curr) => curr.action == AuthAction.resetPassword && prev.status != curr.status,
            buildWhen: (prev, curr) => curr.action == AuthAction.resetPassword && prev.status != curr.status,
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                BridgeXSnackBar.showSuccess(
                  context: context,
                  message: state.message ?? AppFeedbackMessages.passwordResetSuccess,
                );
                context.go(AppRoute.login);
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
                          context.read<AuthCubit>().resetPassword(
                            email: widget.email,
                            code: widget.code,
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
