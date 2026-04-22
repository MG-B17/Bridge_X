import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A8B99), // Blue-grey background from design
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VSpace(context.spacing.xxl),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const RegisterForm(),
                        Positioned(
                          top: -12.h,
                          left: -12.w,
                          child: InkWell(
                            onTap: () => context.pop(),
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: context.colors.surface,
                                shape: BoxShape.circle,
                                boxShadow: [context.spacing.cardShadow],
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: context.colors.primary,
                                size: 20.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    VSpace(context.spacing.xxl),
                  ],
                ),
              ),
            ),
            // Logo at the bottom
            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.xl),
              child: const AppLogo(),
            ),
          ],
        ),
      ),
    );
  }
}
