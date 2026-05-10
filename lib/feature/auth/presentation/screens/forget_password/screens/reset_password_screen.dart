import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/sub_tittle_text.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(AppSpacing.xxl),
                const ScreenNameText(text: AppStrings.securityUpdate),
                VerticalSpacing(AppSpacing.lg),
                const SubTittleText(text: AppStrings.securityUpdateDesc),
                VerticalSpacing(AppSpacing.xxl),
                ResetPasswordForm(
                  email: email,
                  code: code,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}