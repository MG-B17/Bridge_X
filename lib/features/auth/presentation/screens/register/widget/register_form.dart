import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/auth/presentation/controller/register/register_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/register/register_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          LoggerService.warning('Registration failed: ${state.message}', tag: 'RegisterForm');
          ErrorDialog.show(
            context: context,
            title: AppStrings.registrationFailed,
            message: state.message ?? AppFeedbackMessages.genericError,
          );
        } else if (state.status == AuthStatus.success) {
          LoggerService.info('Registration successful', tag: 'RegisterForm');
          context.pushNamed(
            BridgeXRouteNames.verifyEmailCode,
            extra: OtpArgs(email: _emailController.text,),
          );
          BridgeXSnackBar.showSuccess(
            context: context,
            message: state.message ?? AppFeedbackMessages.registrationSuccess,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BridgeXTextFormField(
              label: AppStrings.fullName,
              hint: AppStrings.fullNameHint,
              controller: _nameController,
              keyboardType: TextInputType.name,
              prefixIcon: Icons.person_outline,
              validator: AppValidator.name,
              textInputAction: TextInputAction.next,
            ),
            VerticalSpacing(AppSpacing.md),
            BridgeXTextFormField(
              label: AppStrings.email,
              hint: AppStrings.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: AppValidator.email,
              textInputAction: TextInputAction.next,
            ),
            VerticalSpacing(AppSpacing.md),
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (p, c) => p.isPasswordVisible != c.isPasswordVisible,
              builder: (context, state) => BridgeXTextFormField(
                label: AppStrings.password,
                hint: AppStrings.passwordHint,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !state.isPasswordVisible,
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => context.read<RegisterCubit>().togglePasswordVisibility(),
                ),
                validator: AppValidator.password,
                textInputAction: TextInputAction.next,
              ),
            ),
            VerticalSpacing(AppSpacing.md),
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (p, c) => p.isConfirmPasswordVisible != c.isConfirmPasswordVisible,
              builder: (context, state) => BridgeXTextFormField(
                label: AppStrings.confirmPassword,
                hint: AppStrings.passwordHint,
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !state.isConfirmPasswordVisible,
                prefixIcon: Icons.security_outlined,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => context.read<RegisterCubit>().toggleConfirmPasswordVisibility(),
                ),
                validator: (val) => AppValidator.confirmPassword(_passwordController.text)(val),
                textInputAction: TextInputAction.done,
              ),
            ),
            VerticalSpacing(AppSpacing.md),
            _buildTermsRow(colors),
            VerticalSpacing(AppSpacing.lg),
            BlocBuilder<RegisterCubit, RegisterState>(
              buildWhen: (p, c) => p.status != c.status || p.agreeTerms != c.agreeTerms,
              builder: (context, state) {
                final isLoading = state.status == AuthStatus.loading;
                return BridgeXButton(
                  text: AppStrings.createAccount,
                  isLoading: isLoading,
                  onTap: state.agreeTerms && !isLoading ? _onRegisterTapped : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsRow(dynamic colors) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (p, c) => p.agreeTerms != c.agreeTerms,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSpacing.spacing20,
              height: AppSpacing.height20,
              child: Checkbox(
                value: state.agreeTerms,
                onChanged: (val) => context.read<RegisterCubit>().toggleAgreeTerms(val),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs / 2),
                ),
                side: BorderSide(color: colors.divider, width: 1.5),
                activeColor: colors.primary,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: AppStrings.agreeTermsPrefix,
                  style: context.textTheme.bodySmall?.copyWith(color: colors.textSecondary),
                  children: [
                    TextSpan(
                      text: AppStrings.termsOfService,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: AppStrings.andText,
                      style: context.textTheme.bodySmall?.copyWith(color: colors.textSecondary),
                    ),
                    TextSpan(
                      text: AppStrings.privacyPolicy,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onRegisterTapped() {
    if (_formKey.currentState?.validate() ?? false) {
      LoggerService.debug(
        'Attempting registration for: ${_emailController.text}',
        tag: 'RegisterForm',
      );
      context.read<RegisterCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
      );
    } else {
      LoggerService.warning('Register form validation failed', tag: 'RegisterForm');
    }
  }
}
