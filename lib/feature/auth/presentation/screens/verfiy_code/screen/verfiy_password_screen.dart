import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/sub_tittle_text.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verfiy_code/widget/otp_form.dart';
import 'package:flutter/material.dart';

class VerfiyPasswordScreen extends StatelessWidget {
final OtpArgs otpArgs;

  const VerfiyPasswordScreen({super.key, required this.otpArgs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(AppSpacing.xxl),
              ScreenNameText(text: AppStrings.verifyCode),
              VerticalSpacing(AppSpacing.lg),
              SubTittleText(text: AppStrings.verifyDescription),
              VerticalSpacing(AppSpacing.xxl),
              OtpForm(email:otpArgs.email,verifyAction:AuthAction.verifyPassword,),
            ],
          ),
        ),
      ),
    );
  }
}
