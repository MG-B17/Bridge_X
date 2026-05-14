import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/ai_insights_card.dart';
import '../widgets/greeting_header.dart';
import '../widgets/productivity_section.dart';
import '../widgets/project_bars_card.dart';
import '../widgets/stats_row.dart';
import '../widgets/team_action_buttons.dart';
import '../widgets/tip_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingHeader(),
              VerticalSpacing(AppSpacing.md),
              const TipBanner(),
              VerticalSpacing(AppSpacing.md),
              const TeamActionButtons(),
              VerticalSpacing(AppSpacing.md),
              const StatsRow(),
              VerticalSpacing(AppSpacing.xl),
              const ProductivitySection(),
              VerticalSpacing(AppSpacing.md),
              const ProjectBarsCard(),
              VerticalSpacing(AppSpacing.md),
              const AiInsightsCard(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
