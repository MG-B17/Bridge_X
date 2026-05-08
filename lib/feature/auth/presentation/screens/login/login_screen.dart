import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/auth_container.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_divider.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_footer.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_form.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_header.dart';
import 'package:bridge_x/feature/auth/presentation/screens/login/widget/login_social_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

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
                    // ── Title ───────────────────────────────
                    Text(
                      AppStrings.welcomeBack,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    VerticalSpacing(AppSpacing.sm),
                    Text(
                      AppStrings.loginSubtitle,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.textHint,
                      ),
                    ),
                
                    // ── Form ────────────────────────────────
                    VerticalSpacing(AppSpacing.xxl),
                    const LoginForm(),
                
                    // ── Divider ─────────────────────────────
                    VerticalSpacing(AppSpacing.lg),
                    const LoginDivider(),
                
                    // ── Social Buttons ──────────────────────
                    VerticalSpacing(AppSpacing.md),
                    const LoginSocialRow(),
                
                    // ── Footer ──────────────────────────────
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
