import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/team_card_widget.dart';

class RecommendedTeamsScreen extends StatelessWidget {
  const RecommendedTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 20.sp),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(context.spacing.sm),
            AppButton(
              onPressed: () => context.go(AppRouteConstant.matching),
              label: AppStrings.reload,
            ),
            VSpace(30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.recommendedForYou,
                  style: context.titleLarge.copyWith(
                    color: context.colors.textPrimary,
                    fontSize: 18.sp,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.viewAll,
                    style: context.bodyMedium.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            VSpace(context.spacing.sm),
            TeamCardWidget(
              title: 'Alpha Coders',
              category: 'Mobile App • Fintech',
              description: 'Building a next-gen personal finance app focusing on gamified saving habits and intuitiv...',
              tags: const ['UI/UX', 'Flutter', 'Node.js'],
              membersLabel: '3/5 Members',
              logoColor: const Color(0xFF004080),
              logoText: 'A',
              onTap: () => context.push(AppRouteConstant.workspace),
            ),
            TeamCardWidget(
              title: 'Team up Coders',
              category: 'Mobile App • Fintech',
              description: 'Looking for experienced React developers to help build our next-generation component...',
              tags: const ['React', 'TypeScript', 'Design Systems'],
              membersLabel: '3/5 Members',
              logoColor: const Color(0xFF004080),
              logoText: 'FE',
              status: AppStrings.pendingApproval,
              onTap: () => context.push(AppRouteConstant.workspace),
            ),
            TeamCardWidget(
              title: 'Nexus Web',
              category: 'Web Platform • E-commerce',
              description: 'Creating a headless e-commerce solution for local artisans to easily set up shop and sell...',
              tags: const ['React', 'GraphQL'],
              membersLabel: '3/5 Members',
              logoColor: const Color(0xFF663300),
              logoText: 'N',
              onTap: () => context.push(AppRouteConstant.workspace),
            ),
            VSpace(context.spacing.lg),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) context.go(AppRouteConstant.matching);
          if (index == 1) context.go(AppRouteConstant.chat);
          if (index == 2) context.go(AppRouteConstant.teams);
          if (index == 3) context.go(AppRouteConstant.profile);
        },
      ),
    );
  }
}
