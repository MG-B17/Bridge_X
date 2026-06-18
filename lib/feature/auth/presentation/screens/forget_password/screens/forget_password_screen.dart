import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/text_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/screen_name_text.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/sub_title_text.dart';
import 'package:bridge_x/feature/auth/presentation/controller/password_reset/password_reset_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordResetCubit>(
      create: (_) => sl<PasswordResetCubit>(),
      child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xxl),
          child: Column(
            spacing: AppSpacing.lg,
            children: [
              VerticalSpacing(AppSpacing.xxl),
              SvgPicture.asset("assets/svgs/bridge_x_app_icon.svg", width: AppSpacing.width64, height: AppSpacing.height41),
              const ScreenNameText(text: AppStrings.resetPassword),
              const SubTitleText(text: AppStrings.resetDescription),
              VerticalSpacing(AppSpacing.lg),
              const ForgetPasswordForm(),
              BridgeXTextButton(text: AppStrings.backToLogin, onTap: () => context.pop()),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
