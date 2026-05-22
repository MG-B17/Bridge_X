import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/auth_container.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/sub_tittle_text.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_divider.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_footer.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_form.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_header.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_social_row.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LoginHeader(),
              AuthContainer(
                child: Column(
                  children: [
                    ScreenNameText(text: AppStrings.welcomeBack),
                    VerticalSpacing(AppSpacing.sm),
                    SubTittleText(text: AppStrings.loginSubtitle),
                    VerticalSpacing(AppSpacing.xxl),
                    const LoginForm(),
                    VerticalSpacing(AppSpacing.lg),
                    const LoginDivider(),
                    VerticalSpacing(AppSpacing.md),
                    const LoginSocialRow(),
                    VerticalSpacing(AppSpacing.md),
                    const LoginFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
