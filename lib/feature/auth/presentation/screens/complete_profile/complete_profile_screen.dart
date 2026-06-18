import 'package:bridge_x/core/constant/bridge_x_strings.dart';

import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/experience_level_selector.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/profile_quote.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/profile_setup_header.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/track_selection_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F8FF),
        body: Stack(
          children: [
            // Decorative background SVG blobs
            _BackgroundDecoration(),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(AppSpacing.spacing12),
                    const ProfileSetupHeader(),
                    VerticalSpacing(AppSpacing.spacing24),
                    const TrackSelectionGrid(),
                    VerticalSpacing(AppSpacing.spacing32),
                    const ExperienceLevelSelector(),
                    VerticalSpacing(AppSpacing.spacing32),
                    const ProfileQuote(),
                    VerticalSpacing(AppSpacing.spacing32),
                    // Continue to Matching text button
                    BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                      builder: (context, state) {
                        final isEnabled = state.selectedTrackIndex != -1;
                        return Center(
                          child: GestureDetector(
                            onTap: isEnabled
                                ? () => context
                                    .read<CompleteProfileCubit>()
                                    .submitProfile()
                                : null,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isEnabled ? 1.0 : 0.4,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppStrings.continueText,
                                    style: GoogleFonts.inter(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.primaryBlue,
                                    size: 24.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    VerticalSpacing(AppSpacing.spacing32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const svgPath = 'assets/svgs/track_selection_background.svg';
    const color = Color(0xFF2563EB);

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 60.h,
            left: -10.w,
            child: _buildBlob(svgPath, color, 120.w),
          ),
          Positioned(
            top: 60.h,
            right: -10.w,
            child: _buildBlob(svgPath, color, 100.w),
          ),
          Positioned(
            top: 200.h,
            left: 50.w,
            child: _buildBlob(svgPath, color, 90.w),
          ),
          Positioned(
            top: 350.h,
            right: 20.w,
            child: _buildBlob(svgPath, color, 110.w),
          ),
          Positioned(
            top: 450.h,
            left: -15.w,
            child: _buildBlob(svgPath, color, 100.w),
          ),
          Positioned(
            top: 580.h,
            right: -10.w,
            child: _buildBlob(svgPath, color, 95.w),
          ),
          Positioned(
            top: 700.h,
            left: 30.w,
            child: _buildBlob(svgPath, color, 80.w),
          ),
          Positioned(
            top: 800.h,
            right: 30.w,
            child: _buildBlob(svgPath, color, 85.w),
          ),
        ],
      ),
    );
  }

  Widget _buildBlob(String path, Color color, double size) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color.withValues(alpha: 0.08),
        BlendMode.srcIn,
      ),
    );
  }
}
