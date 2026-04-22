import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import 'social_login_buttons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Handle login
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
          topRight: Radius.circular(80.r), // Custom large curve
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
              48.h, // Top padding
              context.spacing.xl,
              context.spacing.xxl,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      AppStrings.welcomeBack,
                      style: context.displayLarge.copyWith(
                        color: context.colors.primary,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  VSpace(context.spacing.sm),
                  Center(
                    child: Text(
                      'Please enter your details to sign in',
                      style: context.bodyMedium.copyWith(
                        color: context.colors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  VSpace(32.h),
                  Text(
                    AppStrings.email,
                    style: context.bodyMedium.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  VSpace(context.spacing.sm),
                  AppTextField(
                    controller: _emailController,
                    hintText: AppStrings.companyEmailHint,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validator.validateEmail,
                    prefixIcon: Icon(Icons.mail_outline, color: context.colors.textHint),
                  ),
                  VSpace(context.spacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.password,
                        style: context.bodyMedium.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: context.colors.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppStrings.forgotPassword,
                          style: context.bodyMedium.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  VSpace(context.spacing.sm),
                  AppTextField(
                    controller: _passwordController,
                    hintText: '••••••••',
                    obscureText: _obscurePassword,
                    validator: Validator.validatePassword,
                    prefixIcon: Icon(Icons.lock_outline, color: context.colors.textHint),
                  ),
                  VSpace(context.spacing.md),
                  // Remember me checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (val) {
                            setState(() {
                              _rememberMe = val ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                          side: BorderSide(color: context.colors.textHint.withValues(alpha: 0.5)),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Remember me for 30 days',
                        style: context.bodyMedium.copyWith(
                          color: context.colors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  VSpace(context.spacing.xl),
                  AppButton(
                    label: AppStrings.login,
                    onPressed: _submitForm,
                    trailing: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ),
                  VSpace(context.spacing.xxl),
                  Row(
                    children: [
                      Expanded(child: Divider(color: context.colors.textHint.withValues(alpha: 0.3))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
                        child: Text(
                          AppStrings.continueWith.toUpperCase(),
                          style: context.labelSmall.copyWith(
                            color: context.colors.textHint,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: context.colors.textHint.withValues(alpha: 0.3))),
                    ],
                  ),
                  VSpace(context.spacing.xl),
                  const SocialLoginButtons(),
                ],
              ),
            ),
          ),
          // Footer
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: context.spacing.lg),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6), // Light grey footer
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(context.spacing.radiusCardLarge),
                bottomRight: Radius.circular(context.spacing.radiusCardLarge),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppStrings.noAccount.split('?')[0]}? ',
                  style: context.bodyMedium.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.push('/register');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: context.colors.primary,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    AppStrings.signUp,
                    style: context.bodyMedium.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
