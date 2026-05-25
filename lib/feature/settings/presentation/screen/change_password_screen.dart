import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widget/change_password_widget/change_password_form.dart';
import '../widget/change_password_widget/change_password_security_icon.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final ScrollController _scrollController = ScrollController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleUpdatePassword() {
    // TODO: Connect to AuthCubit / ChangePasswordUseCase
    if (_currentPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.currentPasswordHint)),
      );
      return;
    }
    if (_newPasswordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.passwordMinLength)),
      );
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.confirmNewPasswordHint)),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBg,
        body: Stack(
          children: [
            const BridgeXBackgroundGears(),
            SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: AppSpacing.spacing16,
                  right: AppSpacing.spacing16,
                  top: AppSpacing.spacing16,
                  bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BridgeXScreenHeader(
                      title: AppStrings.changePassword,
                      titleStyle: AppTextStyles.headlineMedium.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      spacing: AppSpacing.spacing20,
                    ),
                    VerticalSpacing(AppSpacing.spacing24),
                    const ChangePasswordSecurityIcon(),
                    VerticalSpacing(AppSpacing.spacing24),
                    ChangePasswordForm(
                      currentPasswordController: _currentPasswordController,
                      newPasswordController: _newPasswordController,
                      confirmPasswordController: _confirmPasswordController,
                      showCurrentPassword: _showCurrentPassword,
                      showNewPassword: _showNewPassword,
                      showConfirmPassword: _showConfirmPassword,
                      onCurrentPasswordVisibilityToggle: () =>
                          setState(() => _showCurrentPassword = !_showCurrentPassword),
                      onNewPasswordVisibilityToggle: () =>
                          setState(() => _showNewPassword = !_showNewPassword),
                      onConfirmPasswordVisibilityToggle: () =>
                          setState(() => _showConfirmPassword = !_showConfirmPassword),
                      onUpdatePassword: _handleUpdatePassword,
                    ),
                    VerticalSpacing(AppSpacing.spacing24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
