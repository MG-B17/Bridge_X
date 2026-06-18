import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/profile/presentation/controller/change_password_cubit.dart';
import 'package:bridge_x/feature/profile/presentation/controller/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  bool _isLoadingDialogShowing = false;

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


  void _handleUpdatePassword(BuildContext context) {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (currentPassword.isEmpty) {
      BridgeXSnackBar.showWarning(
        context: context,
        message: AppStrings.currentPasswordHint,
      );
      return;
    }
    if (newPassword.isEmpty) {
      BridgeXSnackBar.showWarning(
        context: context,
        message: AppStrings.newPasswordHint,
      );
      return;
    }
    if (confirmPassword.isEmpty) {
      BridgeXSnackBar.showWarning(
        context: context,
        message: AppStrings.confirmNewPasswordHint,
      );
      return;
    }
    if (newPassword.length < 8) {
      BridgeXSnackBar.showWarning(
        context: context,
        message: AppStrings.passwordMinLength,
      );
      return;
    }
    if (newPassword != confirmPassword) {
      BridgeXSnackBar.showWarning(
        context: context,
        message: AppStrings.confirmNewPasswordHint,
      );
      return;
    }

    context.read<ChangePasswordCubit>().changePassword(
      currentPassword: currentPassword,
      password: newPassword,
      passwordConfirmation: confirmPassword,
    );
  }

  void _showLoadingDialog(BuildContext context) {
    if (_isLoadingDialogShowing) return;
    _isLoadingDialogShowing = true;
    LoadingDialog.show(context: context, message: 'Changing password...').then((_) {
      _isLoadingDialogShowing = false;
    });
  }

  void _hideLoadingDialog(BuildContext context) {
    if (!_isLoadingDialogShowing) return;
    LoadingDialog.hide(context);
    _isLoadingDialogShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (_) => sl<ChangePasswordCubit>(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordLoading) {
            _showLoadingDialog(context);
            return;
          }

          if (state is ChangePasswordSuccess) {
            _hideLoadingDialog(context);
            _currentPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            SuccessDialog.show(
              context: context,
              title: AppStrings.success,
              message: 'Password changed successfully.',
              onAction: () {
                if (context.mounted) context.pop();
              },
            );
          }
          if (state is ChangePasswordError) {
            _hideLoadingDialog(context);
            ErrorDialog.show(
              context: context,
              title: AppStrings.error,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ChangePasswordLoading;

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
                            onUpdatePassword: () => _handleUpdatePassword(context),
                            isLoading: isLoading,
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
        },
      ),
    );
  }
}
