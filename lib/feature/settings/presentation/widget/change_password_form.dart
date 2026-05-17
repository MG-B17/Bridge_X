import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'password_requirements.dart';

class ChangePasswordFormContainer extends StatelessWidget {
  const ChangePasswordFormContainer({
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.showCurrentPassword,
    required this.showNewPassword,
    required this.showConfirmPassword,
    required this.onCurrentPasswordVisibilityToggle,
    required this.onNewPasswordVisibilityToggle,
    required this.onConfirmPasswordVisibilityToggle,
    required this.onUpdatePassword,
    super.key,
  });

  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;
  final VoidCallback onCurrentPasswordVisibilityToggle;
  final VoidCallback onNewPasswordVisibilityToggle;
  final VoidCallback onConfirmPasswordVisibilityToggle;
  final VoidCallback onUpdatePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // ── Description ──
          Text(
            'Manage your Bridge X account security',
            style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textSecondary),
            textAlign: TextAlign.center,
          ),

          VerticalSpacing(AppSpacing.xl),

          // ── Current Password ──
          _PasswordField(
            label: 'CURRENT PASSWORD',
            hint: 'Enter current password',
            controller: currentPasswordController,
            obscureText: !showCurrentPassword,
            prefixIcon: Icons.lock_outlined,
            onVisibilityToggle: onCurrentPasswordVisibilityToggle,
            isVisible: showCurrentPassword,
          ),

          VerticalSpacing(AppSpacing.lg),

          // ── New Password ──
          _PasswordField(
            label: 'NEW PASSWORD',
            hint: 'Enter new password',
            controller: newPasswordController,
            obscureText: !showNewPassword,
            prefixIcon: Icons.vpn_key_outlined,
            onVisibilityToggle: onNewPasswordVisibilityToggle,
            isVisible: showNewPassword,
          ),

          VerticalSpacing(AppSpacing.lg),

          // ── Confirm Password ──
          _PasswordField(
            label: 'CONFIRM NEW PASSWORD',
            hint: 'Confirm new password',
            controller: confirmPasswordController,
            obscureText: !showConfirmPassword,
            prefixIcon: Icons.security_outlined,
            onVisibilityToggle: onConfirmPasswordVisibilityToggle,
            isVisible: showConfirmPassword,
          ),

          VerticalSpacing(AppSpacing.lg),

          // ── Password Requirements ──
          const PasswordRequirements(),

          VerticalSpacing(AppSpacing.xl),

          // ── Update Button ──
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: onUpdatePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0052CC),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Update Password',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Password field with visibility toggle ──
class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.obscureText,
    required this.prefixIcon,
    required this.onVisibilityToggle,
    required this.isVisible,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final IconData prefixIcon;
  final VoidCallback onVisibilityToggle;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: context.colors.textHint,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
          ),
        ),
        VerticalSpacing(8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: context.colors.textHint),
            filled: true,
            fillColor: context.colors.surface,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
            prefixIcon: Icon(prefixIcon, color: context.colors.textHint, size: 20.w),
            suffixIcon: GestureDetector(
              onTap: onVisibilityToggle,
              child: Icon(
                isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: context.colors.textHint,
                size: 20.w,
              ),
            ),
            border: _buildBorder(context.colors.divider),
            enabledBorder: _buildBorder(context.colors.divider),
            focusedBorder: _buildBorder(context.colors.primary, width: 1.5),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
