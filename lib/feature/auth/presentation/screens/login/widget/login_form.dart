import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _rememberMe = false;

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
    final colors = context.colors;

    return Form(
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
          _buildRememberMeRow(colors),
          VerticalSpacing(AppSpacing.sm),
          BridgeXButton(
            text: AppStrings.login,
            onTap: _onLoginTapped,
          ),
        ],
      ),
    );
  }

  Widget _buildRememberMeRow(dynamic colors) {
    return Row(
      children: [
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (val) => setState(() => _rememberMe = val ?? false),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusXs / 2),
            ),
            side: BorderSide(color: colors.divider, width: 1.5),
            activeColor: colors.primary,
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          AppStrings.rememberMe,
          style: context.textTheme.bodySmall?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _onLoginTapped() {
    if (_formKey.currentState?.validate() ?? false) {
      
    }
  }
}
