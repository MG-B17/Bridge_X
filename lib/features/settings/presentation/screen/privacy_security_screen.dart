import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/auth/presentation/controller/account/account_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/account/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/privacy_and_security_widget/account_security_section.dart';
import '../widget/privacy_and_security_widget/danger_zone_section.dart';
import '../widget/privacy_and_security_widget/privacy_disclaimer.dart';
import '../widget/privacy_and_security_widget/protection_card.dart';

import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingDialogShowing = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool?> _showDeleteAccountConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppStrings.deleteAccount),
          content: const Text(
            'Are you sure you want to delete your account? You will be signed out and will need to contact support to restore access if needed.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                AppStrings.deleteAccount,
                style: TextStyle(color: context.colors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLoadingDialog(BuildContext context) {
    if (_isLoadingDialogShowing) return;
    _isLoadingDialogShowing = true;
    LoadingDialog.show(context: context, message: 'Deleting account...').then((_) {
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
    return BlocListener<AccountCubit, AccountState>(
      listenWhen: (previous, current) =>
          current.action == AuthAction.softDeleteProfile,
      listener: (context, state) {
        if (!context.mounted) return;

        if (state.status == AuthStatus.loading) {
          _showLoadingDialog(context);
        } else if (state.status == AuthStatus.success) {
          _hideLoadingDialog(context);
          SuccessDialog.show(
            context: context,
            title: AppStrings.success,
            message: state.message ?? 'Account deleted successfully',
            onAction: () {
              context.read<AccountCubit>().completeSoftDeleteSignOut();
            },
          );
        } else if (state.status == AuthStatus.error) {
          _hideLoadingDialog(context);
          ErrorDialog.show(
            context: context,
            title: AppStrings.error,
            message: state.message ?? 'Failed to delete account',
          );
        }
      },
      child: ScrollNavListener(
        controller: _scrollController,
        child: Scaffold(
          backgroundColor: context.colors.scaffoldBg,
          body: Stack(
            children: [
              const BridgeXBackgroundGears(),
              SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    left: AppSpacing.spacing16,
                    right: AppSpacing.spacing16,
                    top: AppSpacing.spacing16,
                    bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BridgeXScreenHeader(
                        title: AppStrings.privacyAndSecurity,
                      ),
                      VerticalSpacing(AppSpacing.spacing24),
                      const ProtectionCard(),
                      VerticalSpacing(AppSpacing.spacing32),
                      const AccountSecuritySection(),
                      VerticalSpacing(AppSpacing.spacing32),
                      DangerZoneSection(
                        onDeleteTap: () async {
                          final confirmed =
                              await _showDeleteAccountConfirmationDialog();
                          if ((confirmed ?? false) && context.mounted) {
                            context.read<AccountCubit>().softDeleteProfile();
                          }
                        },
                      ),
                      VerticalSpacing(AppSpacing.spacing32),
                      const PrivacyDisclaimer(),
                      VerticalSpacing(AppSpacing.spacing24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
