import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/constant/app_strings.dart';
import 'login_inputs.dart';
import '../../widgets/social_login_buttons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.go(AppRouteConstant.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.spacing.radiusCardLarge),
          bottomLeft: Radius.circular(context.spacing.radiusCardLarge),
          bottomRight: Radius.circular(context.spacing.radiusCardLarge),
          topRight: Radius.circular(80.r),
        ),
        boxShadow: [context.spacing.cardShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.spacing.xl,
              48.h,
              context.spacing.xl,
              context.spacing.xxl,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthHeader(
                    title: AppStrings.welcomeBack,
                    subtitle: 'Please enter your details to sign in',
                  ),
                  LoginInputs(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    obscurePassword: obscurePassword,
                    rememberMe: _rememberMe,
                    onRememberMeChanged: (val) =>
                        setState(() => _rememberMe = val ?? false),
                    onSubmit: _submitForm,
                  ),
                  VSpace(context.spacing.xxl),
                  const AuthDivider(text: AppStrings.continueWith),
                  VSpace(context.spacing.xl),
                  const SocialLoginButtons(),
                ],
              ),
            ),
          ),
          AuthFooter(
            questionText: '${AppStrings.noAccount.split('?')[0]}? ',
            actionText: AppStrings.signUp,
            onActionTap: () => context.push(AppRouteConstant.register),
          ),
        ],
      ),
    );
  }
}
