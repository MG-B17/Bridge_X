import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackSelectionGrid extends StatelessWidget {
  const TrackSelectionGrid({super.key});

  static const List<Map<String, dynamic>> tracks = [
    {'label': 'Frontend', 'icon': Icons.computer_outlined},
    {'label': 'UI/UX', 'icon': Icons.design_services_outlined},
    {'label': 'DevOps', 'icon': Icons.sync_alt_outlined},
    {'label': 'Data science', 'icon': Icons.hub_outlined},
    {'label': 'Backend', 'icon': Icons.storage_outlined},
    {'label': 'AI', 'icon': Icons.psychology_outlined},
    {'label': 'Mobile', 'icon': Icons.smartphone_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with Required badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.selectTrack,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.primaryBlue.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                AppStrings.required,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
          builder: (context, state) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 24.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.82,
              ),
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final isSelected = state.selectedTrackIndex == index;
                return GestureDetector(
                  onTap: () =>
                      context.read<CompleteProfileCubit>().selectTrack(index),
                  child: _TrackCard(
                    label: tracks[index]['label'] as String,
                    icon: tracks[index]['icon'] as IconData,
                    isSelected: isSelected,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _TrackCard extends StatelessWidget {
  const _TrackCard({
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Circle card
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withValues(
                      alpha: isSelected ? 0.15 : 0.06,
                    ),
                    blurRadius: isSelected ? 16 : 10,
                    spreadRadius: isSelected ? 2 : 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background SVG blob
                  SvgPicture.asset(
                    'assets/svgs/track_selection_background.svg',
                    width: 80.w,
                    height: 80.w,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? AppColors.primaryBlue.withValues(alpha: 0.15)
                          : AppColors.lightBlue.withValues(alpha: 0.6),
                      BlendMode.srcIn,
                    ),
                  ),
                  // Track icon
                  Icon(
                    icon,
                    size: 28.sp,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
            // Check badge at bottom-left
            if (isSelected)
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.sp,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColors.primaryBlue : AppColors.navyBlue,
          ),
        ),
      ],
    );
  }
}
