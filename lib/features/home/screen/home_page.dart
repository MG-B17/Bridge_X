import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/home_header.dart';
import '../widgets/home_tip_banner.dart';
import '../widgets/home_action_buttons.dart';
import '../widgets/home_stats_row.dart';
import '../widgets/productivity_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              VSpace(context.spacing.xl),
              const HomeTipBanner(),
              VSpace(context.spacing.xl),
              const HomeActionButtons(),
              VSpace(context.spacing.xl),
              const HomeStatsRow(),
              VSpace(context.spacing.xxl),
              const ProductivitySection(),
              VSpace(context.spacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
