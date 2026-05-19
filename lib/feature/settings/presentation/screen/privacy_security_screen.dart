import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widget/privacy_and_security_widget/account_security_section.dart';
import '../widget/privacy_and_security_widget/danger_zone_section.dart';
import '../widget/privacy_and_security_widget/privacy_disclaimer.dart';
import '../widget/privacy_and_security_widget/protection_card.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: Stack(
        children: [
          const BridgeXBackgroundGears(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BridgeXScreenHeader(
                    title: AppStrings.privacyAndSecurity,
                  ),
                  VerticalSpacing(AppSpacing.xl),
                  const ProtectionCard(),
                  VerticalSpacing(AppSpacing.xxl),
                  const AccountSecuritySection(),
                  VerticalSpacing(AppSpacing.xxl),
                  const DangerZoneSection(),
                  VerticalSpacing(AppSpacing.xxl),
                  const PrivacyDisclaimer(),
                  VerticalSpacing(AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
