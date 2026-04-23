import 'package:bridgex/core/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../../../../core/widgets/v_space.dart';
import '../../widgets/social_login_buttons.dart';
import 'register_inputs.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to the Terms of Service')),
        );
        return;
      }
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
      child: Form(
        key: _formKey,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthHeader(title: AppStrings.createAccount),
                  RegisterInputs(
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    obscurePassword: obscurePassword,
                    obscureConfirmPassword: obscureConfirmPassword,
                    agreeTerms: _agreeTerms,
                    onAgreeTermsChanged: (val) =>
                        setState(() => _agreeTerms = val ?? false),
                    onSubmit: _submitForm,
                  ),
                  VSpace(context.spacing.xxl),
                  const AuthDivider(text: AppStrings.signUpWith),
                  VSpace(context.spacing.xl),
                  const SocialLoginButtons(),
                ],
              ),
            ),
            AuthFooter(
              questionText: '${AppStrings.alreadyHaveAccount.split('?')[0]}? ',
              actionText: AppStrings.login,
              onActionTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
