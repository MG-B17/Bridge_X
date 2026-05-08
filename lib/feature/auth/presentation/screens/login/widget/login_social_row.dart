import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/github_widget.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/google_widget.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSocialRow extends StatelessWidget {
  const LoginSocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(onTap: () {}, child: const GithubWidget()),
        HorizontalSpacing(16.w),
        SocialButton(onTap: () {}, child: const GoogleWidget()),
      ],
    );
  }
}
