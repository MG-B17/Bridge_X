
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildScreenHeader(context),
              VSpace(context.spacing.xxl * 2),
              _buildBridgeXInfo(context),
              VSpace(context.spacing.xxl),
              _buildMissionCard(context),
              const Spacer(),
              _buildFooter(context),
              VSpace(context.spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _buildScreenHeader(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppStrings.aboutUs,
        style: context.displayLarge.copyWith(
          color: context.colors.textPrimary,
          fontSize: 28.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildBridgeXInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.appName,
          style: context.displayLarge.copyWith(
            color: context.colors.primary,
            fontSize: 32.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        VSpace(context.spacing.sm),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.lg),
          child: Text(
            AppStrings.aboutBridgeXDesc,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
        VSpace(context.spacing.lg),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing.md,
            vertical: context.spacing.xs,
          ),
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(context.spacing.radiusPill),
          ),
          child: Text(
            AppStrings.version.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.rocket_launch_outlined,
            color: context.colors.primary,
            size: 24.w,
          ),
          VSpace(context.spacing.sm),
          Text(
            AppStrings.ourMission,
            style: context.titleLarge.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          VSpace(context.spacing.xs),
          Text(
            AppStrings.ourMissionDesc,
            style: context.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Text(
      AppStrings.madeWithLove,
      style: context.labelSmall.copyWith(
        color: context.colors.textSecondary,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }
}
