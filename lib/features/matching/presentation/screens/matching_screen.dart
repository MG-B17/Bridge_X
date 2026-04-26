import '../../../../core/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
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
      backgroundColor: context.colors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: context.colors.primary, size: 20.sp),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
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
}
