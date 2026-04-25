import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/empty_state_illustration.dart';

class NoTeamsScreen extends StatelessWidget {
  const NoTeamsScreen({super.key});

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
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 20.sp),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: Center(
                child: EmptyStateIllustration(),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Text(
                    AppStrings.noTeamsFound,
                    textAlign: TextAlign.center,
                    style: context.displayLarge.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  VSpace(context.spacing.md),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      AppStrings.noTeamsFoundSubtitle,
                      textAlign: TextAlign.center,
                      style: context.bodyMedium.copyWith(
                        color: context.colors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  AppButton(
                    label: AppStrings.retryMatching,
                    onPressed: () => context.go(AppRouteConstant.matching),
                    trailing: Icon(
                      Icons.explore_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                  VSpace(context.spacing.md),
                  AppButton(
                    label: AppStrings.createYourOwnTeam,
                    isSecondary: true,
                    onPressed: () => context.push(AppRouteConstant.createTeam),
                  ),
                  VSpace(context.spacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
