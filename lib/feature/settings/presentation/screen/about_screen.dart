import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_screen_header.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import '../widget/about_widget/about_app_info.dart';
import '../widget/about_widget/about_footer.dart';
import '../widget/about_widget/about_mission_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                horizontal: AppSpacing.spacing16,
                vertical: AppSpacing.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BridgeXScreenHeader(
                    title: AppStrings.aboutUs,
                  ),
                  VerticalSpacing(AppSpacing.height40),
                  const AboutAppInfo(),
                  VerticalSpacing(AppSpacing.height40),
                  const AboutMissionCard(),
                  VerticalSpacing(AppSpacing.height80),
                  const AboutFooter(),
                  VerticalSpacing(AppSpacing.spacing24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
