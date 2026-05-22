import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/auth_container.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/feature/auth/presentation/screens/register/widget/register_divider.dart';
import 'package:bridge_x/feature/auth/presentation/screens/register/widget/register_footer.dart';
import 'package:bridge_x/feature/auth/presentation/screens/register/widget/register_form.dart';
import 'package:bridge_x/feature/auth/presentation/screens/register/widget/register_social_row.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(AppSpacing.xxl+AppSpacing.lg),
              AuthContainer(
                child: Column(
                  children: [
                    const ScreenNameText(text: AppStrings.createAccount),
                    
                    VerticalSpacing(AppSpacing.xxl),
                
                    
                    const RegisterForm(),
                
                    
                    VerticalSpacing(AppSpacing.lg),
                    const RegisterDivider(),
                
                    
                    VerticalSpacing(AppSpacing.md),
                    const RegisterSocialRow(),
                
                    
                    VerticalSpacing(AppSpacing.md),
                    const RegisterFooter(),
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
