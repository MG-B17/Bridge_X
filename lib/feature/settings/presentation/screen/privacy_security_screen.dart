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

import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBg,
        body: Stack(
          children: [
            const BridgeXBackgroundGears(),
            SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  left: AppSpacing.spacing16,
                  right: AppSpacing.spacing16,
                  top: AppSpacing.spacing16,
                  bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BridgeXScreenHeader(
                      title: AppStrings.privacyAndSecurity,
                    ),
                    VerticalSpacing(AppSpacing.spacing24),
                    const ProtectionCard(),
                    VerticalSpacing(AppSpacing.spacing32),
                    const AccountSecuritySection(),
                    VerticalSpacing(AppSpacing.spacing32),
                    const DangerZoneSection(),
                    VerticalSpacing(AppSpacing.spacing32),
                    const PrivacyDisclaimer(),
                    VerticalSpacing(AppSpacing.spacing24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
