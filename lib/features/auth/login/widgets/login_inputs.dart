import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';

class LoginInputs extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onSubmit;

  const LoginInputs({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.email,
          style: context.bodyMedium.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: emailController,
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
              onPressed: () => context.push(AppRouteConstant.forgetPassword),
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
          controller: passwordController,
          hintText: '••••••••',
          obscureText: obscurePassword,
          validator: Validator.validatePassword,
          prefixIcon: Icon(Icons.lock_outline, color: context.colors.textHint),
        ),
        VSpace(context.spacing.md),
        Row(
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: Checkbox(
                value: rememberMe,
                onChanged: onRememberMeChanged,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                side: BorderSide(
                  color: context.colors.textHint.withValues(alpha: 0.5),
                ),
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
          onPressed: onSubmit,
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }
}
