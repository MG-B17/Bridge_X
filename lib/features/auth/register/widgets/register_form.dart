import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../../login/widgets/social_login_buttons.dart';

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
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
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
        // Show error for terms
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please agree to the Terms of Service')),
        );
        return;
      }
      // TODO: Handle registration
    }
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text.toUpperCase(),
      style: context.labelSmall.copyWith(
        color: context.colors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
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
      child: Form(
        key: _formKey,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      AppStrings.createAccount,
                      style: context.displayLarge.copyWith(
                        color: context.colors.primary,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  VSpace(32.h),
                  _buildLabel(context, AppStrings.fullName),
                  VSpace(context.spacing.sm),
                  AppTextField(
                    controller: _nameController,
                    hintText: 'Eman tweeg', // Placeholder from image
                    keyboardType: TextInputType.name,
                    validator: Validator.validateName,
                    prefixIcon: Icon(Icons.person_outline, color: context.colors.textHint),
                  ),
                  VSpace(context.spacing.lg),
                  _buildLabel(context, AppStrings.email),
                  VSpace(context.spacing.sm),
                  AppTextField(
                    controller: _emailController,
                    hintText: AppStrings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validator.validateEmail,
                    prefixIcon: Icon(Icons.mail_outline, color: context.colors.textHint),
                  ),
                  VSpace(context.spacing.lg),
                  _buildLabel(context, AppStrings.password),
                  VSpace(context.spacing.sm),
                  AppTextField(
                    controller: _passwordController,
                    hintText: '••••••••',
                    obscureText: _obscurePassword,
                    validator: Validator.validatePassword,
                    prefixIcon: Icon(Icons.lock_outline, color: context.colors.textHint),
                  ),
                  VSpace(context.spacing.lg),
                  _buildLabel(context, AppStrings.confirmPassword),
                  VSpace(context.spacing.sm),
                  AppTextField(
                    controller: _confirmPasswordController,
                    hintText: '••••••••',
                    obscureText: _obscureConfirmPassword,
                    validator: (val) => Validator.validateConfirmPassword(val, _passwordController.text),
                    prefixIcon: Icon(Icons.shield_outlined, color: context.colors.textHint),
                  ),
                  VSpace(context.spacing.md),
                  // Terms Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Checkbox(
                          value: _agreeTerms,
                          onChanged: (val) {
                            setState(() {
                              _agreeTerms = val ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                          side: BorderSide(color: context.colors.textHint.withValues(alpha: 0.5)),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: context.bodyMedium.copyWith(
                              color: context.colors.textSecondary,
                              fontSize: 12.sp,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: ' and\n'),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  VSpace(context.spacing.xl),
                  AppButton(
                    label: AppStrings.createAccount,
                    onPressed: _submitForm,
                  ),
                  VSpace(context.spacing.xxl),
                  Row(
                    children: [
                      Expanded(child: Divider(color: context.colors.textHint.withValues(alpha: 0.3))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
                        child: Text(
                          AppStrings.signUpWith,
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
                    '${AppStrings.alreadyHaveAccount.split('?')[0]}? ',
                    style: context.bodyMedium.copyWith(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: context.colors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      AppStrings.login,
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
      ),
    );
  }
}
