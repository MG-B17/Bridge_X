import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/text_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/sub_tittle_text.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xxl).r,
          child: Column(
            spacing: AppSpacing.lg,
            children: [
              VerticalSpacing(AppSpacing.xxl),
              SvgPicture.asset("assets/svgs/bridge_x_app_icon.svg", width: 64.w, height: 41.h),
              const ScreenNameText(text: AppStrings.resetPassword),
              const SubTittleText(text: AppStrings.resetDescription),
              VerticalSpacing(AppSpacing.lg),
              const ForgetPasswordForm(),
              BridgeXTextButton(text: AppStrings.backToLogin, onTap: () => context.pop()),
            ],
          ),
        ),
      ),
    );
  }
}
