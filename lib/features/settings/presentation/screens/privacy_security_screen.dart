import 'package:flutter/material.dart';
import '../../../../core/navigation/app_route_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/privacy_security_widgets.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScreenHeader(context),
            VSpace(context.spacing.lg),
            const ProtectionBanner(),
            VSpace(context.spacing.xxl),
            const SecuritySectionHeader(
              label: AppStrings.accountSecurity,
              icon: Icons.shield_outlined,
            ),
            VSpace(context.spacing.md),
            _buildAccountSecurityCard(context),
            VSpace(context.spacing.xxl),
            const SecuritySectionHeader(
              label: AppStrings.dangerZone,
              icon: Icons.warning_amber_rounded,
              iconColor: Color(0xFFB91C1C),
            ),
            VSpace(context.spacing.md),
            const DangerZoneCard(),
            VSpace(context.spacing.xxl),
            const PrivacyDisclaimerCard(),
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
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _buildScreenHeader(BuildContext context) {
    return Text(
      AppStrings.privacyAndSecurity,
      style: context.displayLarge.copyWith(
        color: context.colors.textPrimary,
        fontSize: 28.sp,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildAccountSecurityCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        children: [
          SecurityMenuItem(
            title: AppStrings.changePassword,
            icon: Icons.password_rounded,
            iconColor: const Color(0xFF3B82F6),
            iconBgColor: const Color(0xFFEFF6FF),
            showChevron: true,
            onTap: () => context.push(AppRouteConstant.changePasswordScreen),
          ),
          SecurityMenuItem(
            title: AppStrings.emailAddress,
            subtitle: 'ahmed.t@bridgex.com',
            icon: Icons.alternate_email_rounded,
            iconColor: const Color(0xFF3B82F6),
            iconBgColor: const Color(0xFFEFF6FF),
            showDivider: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
