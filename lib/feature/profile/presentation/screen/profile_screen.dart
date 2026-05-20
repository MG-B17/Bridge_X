import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import '../widget/profile_screen_widget/profile_header.dart';
import '../widget/profile_screen_widget/profile_stats.dart';
import '../widget/profile_screen_widget/profile_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: AppSpacing.spacing20,
              right: AppSpacing.spacing20,
              top: AppSpacing.spacing20,
              bottom: AppSpacing.spacing20 + AppSpacing.spacing20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileHeader(),
                VerticalSpacing(AppSpacing.spacing24),
                const ProfileStats(),
                VerticalSpacing(AppSpacing.spacing24),
                const ProfileMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
