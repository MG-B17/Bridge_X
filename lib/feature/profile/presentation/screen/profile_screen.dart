import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import '../widget/profile_screen_widget/profile_header.dart';
import '../widget/profile_screen_widget/profile_stats.dart';
import '../widget/profile_screen_widget/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              VerticalSpacing(AppSpacing.xl),
              const ProfileStats(),
              VerticalSpacing(AppSpacing.xl),
              const ProfileMenu(),
            ],
          ),
        ),
      ),
    );
  }
}