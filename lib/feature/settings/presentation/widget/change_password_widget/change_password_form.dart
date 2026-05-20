import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'password_requirements.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Current Password ──
        BridgeXTextFormField(
          label: AppStrings.currentPassword,
          hint: AppStrings.currentPasswordHint,
          controller: currentPasswordController,
          prefixIcon: Icons.lock_outlined,
          obscureText: !showCurrentPassword,
          suffixIcon: _VisibilityToggle(
            isVisible: showCurrentPassword,
            onTap: onCurrentPasswordVisibilityToggle,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing20),

        // ── New Password ──
        BridgeXTextFormField(
          label: AppStrings.newPasswordLabel,
          hint: AppStrings.newPasswordHint,
          controller: newPasswordController,
          prefixIcon: Icons.vpn_key_outlined,
          obscureText: !showNewPassword,
          suffixIcon: _VisibilityToggle(
            isVisible: showNewPassword,
            onTap: onNewPasswordVisibilityToggle,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing20),

        // ── Confirm Password ──
        BridgeXTextFormField(
          label: AppStrings.confirmNewPassword,
          hint: AppStrings.confirmNewPasswordHint,
          controller: confirmPasswordController,
          prefixIcon: Icons.security_outlined,
          obscureText: !showConfirmPassword,
          suffixIcon: _VisibilityToggle(
            isVisible: showConfirmPassword,
            onTap: onConfirmPasswordVisibilityToggle,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing20),

        // ── Password Requirements ──
        const PasswordRequirements(),
        VerticalSpacing(AppSpacing.spacing32),

        // ── Submit Button ──
        BridgeXButton(
          text: AppStrings.updatePassword,
          onTap: onUpdatePassword,
          suffixicon: Icons.arrow_forward,
        ),
      ],
    );
  }
}

class _VisibilityToggle extends StatelessWidget {
  const _VisibilityToggle({required this.isVisible, required this.onTap});
  final bool isVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: context.colors.textHint,
        size: AppSpacing.spacing20,
      ),
    );
  }
}
