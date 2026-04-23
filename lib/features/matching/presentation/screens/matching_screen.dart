import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/info_card_widget.dart';
import '../widgets/progress_circle_widget.dart';
import '../widgets/matching_details.dart';
import '../widgets/matching_skill_progress.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MatchingHeader(),
            VSpace(context.spacing.xxl),
            GestureDetector(
              onTap: () => context.push(AppRouteConstant.teams),
              child: const ProgressCircleWidget(
                percentage: 45,
                statusText: AppStrings.optimizing,
              ),
            ),
            VSpace(context.spacing.xxl),
            const InfoCardWidget(
              icon: Icons.psychology_outlined,
              title: AppStrings.dynamicInsight,
              subtitle: AppStrings.dynamicInsightSubtitle,
            ),
            VSpace(context.spacing.xl),
            const MatchingSkillProgress(),
            VSpace(context.spacing.xl),
            const MatchingStatusList(),
            VSpace(context.spacing.xxl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.primary),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
