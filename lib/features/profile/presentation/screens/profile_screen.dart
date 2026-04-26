import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_stats.dart';
import '../widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(),
              VSpace(context.spacing.md),
              const ProfileAvatar(),
              VSpace(context.spacing.xxl),
              _buildUserInfo(context),
              VSpace(context.spacing.xxl),
              const ProfileStats(),
              VSpace(context.spacing.xxl),
              const ProfileMenu(),
              VSpace(context.spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ahmed Ali',
          style: context.displayLarge.copyWith(
            color: context.colors.textPrimary,
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        VSpace(context.spacing.xs),
        Text(
          'Beginner Frontend Developer',
          style: context.bodyMedium.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
