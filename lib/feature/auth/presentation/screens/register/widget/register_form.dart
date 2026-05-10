import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/widget/error_dialog.dart';
import 'package:bridge_x/core/widget/bridge_x_snackbar.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool _agreeTerms = false;

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

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => curr.action == AuthAction.register && prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          LoggerService.warning('Registration failed: ${state.message}', tag: 'RegisterForm');
          ErrorSnackBar.show(context, state.message ?? 'An error occurred');
        } else if (state.status == AuthStatus.success) {
          LoggerService.info('Registration successful', tag: 'RegisterForm');
          BridgeXSnackBar.showSuccess(
            context: context,
            message: state.message ?? 'Registration successful!',
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
          BridgeXTextFormField(
            label: AppStrings.password,
            hint: AppStrings.passwordHint,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            prefixIcon: Icons.lock_outline,
            validator: AppValidator.password,
            textInputAction: TextInputAction.next,
          ),
          VerticalSpacing(AppSpacing.md),
          BridgeXTextFormField(
            label: AppStrings.confirmPassword,
            hint: AppStrings.passwordHint,
            controller: _confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            prefixIcon: Icons.security_outlined,
            validator: (val) => AppValidator.confirmPassword(_passwordController.text)(val),
            textInputAction: TextInputAction.done,
          ),
          VerticalSpacing(AppSpacing.md),
          _buildTermsRow(colors),
          VerticalSpacing(AppSpacing.lg),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isLoading = state.status == AuthStatus.loading && state.action == AuthAction.register;
              return BridgeXButton(
                text: AppStrings.createAccount,
                isLoading: isLoading,
                onTap: _agreeTerms && !isLoading ? _onRegisterTapped : null,
              );
            },
          ),
        ],
      ),
    ));
  }

  Widget _buildTermsRow(dynamic colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: Checkbox(
            value: _agreeTerms,
            onChanged: (val) => setState(() => _agreeTerms = val ?? false),
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
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
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
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
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
  }

  void _onRegisterTapped() {
    if (_formKey.currentState?.validate() ?? false) {
      LoggerService.debug('Attempting registration for: ${_emailController.text}', tag: 'RegisterForm');
      context.read<AuthCubit>().register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
      );
    } else {
      LoggerService.warning('Register form validation failed', tag: 'RegisterForm');
    }
  }
}
