import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import 'team_card_widget.dart';

class RecommendedHeader extends StatelessWidget {
  const RecommendedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(context.spacing.sm),
        AppButton(
          onPressed: () => context.go(AppRouteConstant.matching),
          label: AppStrings.reload,
        ),
        VSpace(context.spacing.xxl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.recommendedForYou,
              style: context.titleLarge.copyWith(
                color: context.colors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.viewAll,
                style: context.bodyMedium.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RecommendedTeamList extends StatelessWidget {
  const RecommendedTeamList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeamCardWidget(
          title: 'Alpha Coders',
          category: 'Mobile App • Fintech',
          description: 'Building a next-gen personal finance app focusing on gamified saving habits...',
          tags: const ['UI/UX', 'Flutter', 'Node.js'],
          membersLabel: '3/5 Members',
          logoColor: const Color(0xFF004080),
          logoText: 'A',
          onTap: () => context.push(AppRouteConstant.workspace),
        ),
        TeamCardWidget(
          title: 'Team up Coders',
          category: 'Mobile App • Fintech',
          description: 'Looking for experienced React developers to help build our next-generation...',
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
          description: 'Creating a headless e-commerce solution for local artisans...',
          tags: const ['React', 'GraphQL'],
          membersLabel: '3/5 Members',
          logoColor: const Color(0xFF663300),
          logoText: 'N',
          onTap: () => context.push(AppRouteConstant.workspace),
        ),
      ],
    );
  }
}
