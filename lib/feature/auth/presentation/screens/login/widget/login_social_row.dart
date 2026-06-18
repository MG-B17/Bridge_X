import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/github_widget.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/google_widget.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/social_button.dart';
import 'package:flutter/material.dart';

class LoginSocialRow extends StatelessWidget {
  const LoginSocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(onTap: () {/* TODO: implement GitHub login */}, child: const GithubWidget()),
        HorizontalSpacing(AppSpacing.spacing16),
        SocialButton(onTap: () {/* TODO: implement Google login */}, child: const GoogleWidget()),
      ],
    );
  }
}
