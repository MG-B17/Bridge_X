import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScreenHeader(context),
            VSpace(context.spacing.xl),
            _buildSecurityBadge(context),
            VSpace(context.spacing.md),
            Text(
              AppStrings.securityUpdate,
              textAlign: TextAlign.center,
              style: context.displayLarge.copyWith(
                color: context.colors.textPrimary,
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            VSpace(context.spacing.xs),
            Text(
              AppStrings.securityUpdateDesc,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
            VSpace(context.spacing.xxl),
            _buildPasswordForm(context),
            VSpace(context.spacing.xxl),
            _buildForgotPasswordLink(context),
            VSpace(context.spacing.xxl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _buildScreenHeader(BuildContext context) {
    return Text(
      AppStrings.changePassword,
      style: context.displayLarge.copyWith(
        color: context.colors.textPrimary,
        fontSize: 28.sp,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildSecurityBadge(BuildContext context) {
    return Center(
      child: Container(
        width: 64.w,
        height: 64.w,
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          Icons.enhanced_encryption_rounded,
          color: context.colors.primary,
          size: 32.w,
        ),
      ),
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel(context, AppStrings.currentPassword),
          VSpace(context.spacing.sm),
          AppTextField(
            controller: _currentPasswordController,
            hintText: '••••••••',
            obscureText: true,
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: context.colors.textHint,
              size: 20.w,
            ),
          ),
          VSpace(context.spacing.xl),
          _buildFieldLabel(context, AppStrings.newPassword),
          VSpace(context.spacing.sm),
          AppTextField(
            controller: _newPasswordController,
            hintText: '••••••••',
            obscureText: true,
            prefixIcon: Icon(
              Icons.password_rounded,
              color: context.colors.textHint,
              size: 20.w,
            ),
          ),
          VSpace(context.spacing.xl),
          _buildFieldLabel(context, AppStrings.confirmNewPassword),
          VSpace(context.spacing.sm),
          AppTextField(
            controller: _confirmPasswordController,
            hintText: '••••••••',
            obscureText: true,
            prefixIcon: Icon(
              Icons.shield_outlined,
              color: context.colors.textHint,
              size: 20.w,
            ),
          ),
          VSpace(context.spacing.md),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 14.w,
                color: context.colors.textSecondary,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  AppStrings.passwordMinLength,
                  style: context.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          VSpace(context.spacing.xl),
          AppButton(
            label: AppStrings.updatePassword,
            onPressed: _onUpdatePassword,
            trailing: Icon(Icons.arrow_forward, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    return Text(
      label.toUpperCase(),
      style: context.labelSmall.copyWith(
        color: context.colors.textSecondary,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => context.push(AppRouteConstant.forgotPassword),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.forgotPassword,
              style: context.bodyMedium.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.open_in_new_rounded,
              color: context.colors.primary,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }

  void _onUpdatePassword() {
    // TODO: Validate and submit password change
  }
}
