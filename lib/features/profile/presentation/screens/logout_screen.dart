import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_dialog.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: Stack(
        children: [
          Center(
            child: BridgeDialog(
              icon: Icons.logout_rounded,
              iconColor: context.colors.primary,
              iconBgColor: const Color(0xFFDBEAFE),
              title: AppStrings.logoutTitle,
              description: AppStrings.logoutConfirm,
              primaryButtonLabel: AppStrings.logout,
              onPrimaryPressed: () {
                context.go(AppRouteConstant.login);
              },
              textLinkLabel: AppStrings.cancel,
              onTextLinkPressed: () => context.pop(),
            ),
          ),
          Positioned(
            bottom: context.spacing.xxl,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                AppStrings.appName,
                style: context.bodyMedium.copyWith(
                  color: context.colors.primary.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
