import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../widgets/auth_header.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.push('/otp-verification');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24.r), 
        boxShadow: [context.spacing.cardShadow],
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: 48.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo()),
              VSpace(context.spacing.md),
              const AuthHeader(
                title: AppStrings.resetPassword,
                subtitle: AppStrings.resetDescription,
              ),
              Text(
                AppStrings.email,
                style: context.bodyMedium.copyWith(color: context.colors.textPrimary, fontWeight: FontWeight.w600),
              ),
              VSpace(context.spacing.sm),
              AppTextField(
                controller: _emailController,
                hintText: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                validator: Validator.validateEmail,
                prefixIcon: Icon(Icons.mail_outline, color: context.colors.textHint),
              ),
              VSpace(32.h),
              AppButton(label: AppStrings.sendResetLink, onPressed: _submitForm),
              VSpace(32.h),
              TextButton.icon(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 18.w),
                label: Text(
                  AppStrings.backToLogin,
                  style: context.bodyMedium.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
