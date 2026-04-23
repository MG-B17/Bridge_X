import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';

class RegisterInputs extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeTerms;
  final ValueChanged<bool?> onAgreeTermsChanged;
  final VoidCallback onSubmit;

  const RegisterInputs({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.agreeTerms,
    required this.onAgreeTermsChanged,
    required this.onSubmit,
  });

  Widget _buildLabel(BuildContext ctx, String text) => Text(
    text.toUpperCase(),
    style: ctx.labelSmall.copyWith(
      color: ctx.colors.textPrimary,
      fontWeight: FontWeight.w600,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(context, AppStrings.fullName),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: nameController,
          hintText: 'Eman tweeg',
          keyboardType: TextInputType.name,
          validator: Validator.validateName,
          prefixIcon: Icon(
            Icons.person_outline,
            color: context.colors.textHint,
          ),
        ),
        VSpace(context.spacing.lg),
        _buildLabel(context, AppStrings.email),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: emailController,
          hintText: AppStrings.emailHint,
          keyboardType: TextInputType.emailAddress,
          validator: Validator.validateEmail,
          prefixIcon: Icon(Icons.mail_outline, color: context.colors.textHint),
        ),
        VSpace(context.spacing.lg),
        _buildLabel(context, AppStrings.password),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: passwordController,
          hintText: '••••••••',
          obscureText: obscurePassword,
          validator: Validator.validatePassword,
          prefixIcon: Icon(Icons.lock_outline, color: context.colors.textHint),
        ),
        VSpace(context.spacing.lg),
        _buildLabel(context, AppStrings.confirmPassword),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: confirmPasswordController,
          hintText: '••••••••',
          obscureText: obscureConfirmPassword,
          validator: (val) =>
              Validator.validateConfirmPassword(val, passwordController.text),
          prefixIcon: Icon(
            Icons.shield_outlined,
            color: context.colors.textHint,
          ),
        ),
        VSpace(context.spacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: Checkbox(
                value: agreeTerms,
                onChanged: onAgreeTermsChanged,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                side: BorderSide(
                  color: context.colors.textHint.withValues(alpha: 0.5),
                ),
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
        AppButton(label: AppStrings.createAccount, onPressed: onSubmit),
      ],
    );
  }
}
