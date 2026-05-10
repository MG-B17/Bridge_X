import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/bridge_x_route_constant.dart';
import 'package:bridge_x/core/services/logger_service.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/error_dialog.dart';

import 'package:bridge_x/core/widget/text_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => curr.action == AuthAction.login && prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          LoggerService.warning('Login failed: ${state.message}', tag: 'LoginForm');
          ErrorDialog.show(
            context: context,
            title: AppStrings.loginFailed,
            message: state.message ?? AppFeedbackMessages.genericError,
          );
        } else if (state.status == AuthStatus.success) {
          LoggerService.info('Login successful', tag: 'LoginForm');
          BridgeXSnackBar.showSuccess(context: context, message: state.message ?? AppFeedbackMessages.loginSuccess);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BridgeXTextFormField(
              label: AppStrings.email,
              hint: AppStrings.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              prefixIcon: Icons.email_outlined,
              validator: AppValidator.email,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
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
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
            ),
            VerticalSpacing(AppSpacing.md),
            _buildForgotPasswordRow(),
            VerticalSpacing(AppSpacing.sm),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final isLoading = state.status == AuthStatus.loading && state.action == AuthAction.login;
                return BridgeXButton(
                  text: AppStrings.login,
                  isLoading: isLoading,
                  onTap: isLoading ? null : _onLoginTapped,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BridgeXTextButton(
          text: AppStrings.forgotPassword,
          onTap: () {
            context.push(AppRoute.forgotPassword);
          },
        ),
      ],
    );
  }

  void _onLoginTapped() {
    if (_formKey.currentState?.validate() ?? false) {
      LoggerService.debug('Attempting login for: ${_emailController.text}', tag: 'LoginForm');
      context.read<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } else {
      LoggerService.warning('Login form validation failed', tag: 'LoginForm');
    }
  }
}
