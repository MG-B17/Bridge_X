import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackSelectionGrid extends StatelessWidget {
  const TrackSelectionGrid({super.key});

  static const List<Map<String, dynamic>> tracks = [
    {'label': 'Frontend', 'icon': Icons.web},
    {'label': 'UI/UX', 'icon': Icons.design_services_outlined},
    {'label': 'DevOps', 'icon': Icons.cloud_done_outlined},
    {'label': 'Data science', 'icon': Icons.analytics_outlined},
    {'label': 'Backend', 'icon': Icons.storage_outlined},
    {'label': 'AI', 'icon': Icons.psychology_outlined},
    {'label': 'Mobile', 'icon': Icons.smartphone_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.selectTrack,
              style: text.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                AppStrings.required,
                style: text.labelSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.lg),
        BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
          builder: (context, state) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20.h,
                crossAxisSpacing: 20.w,
                childAspectRatio: 0.8,
              ),
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final isSelected = state.selectedTrackIndex == index;
                return GestureDetector(
                  onTap: () => context.read<CompleteProfileCubit>().selectTrack(index),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/track_selection_background.svg',
                                  colorFilter: ColorFilter.mode(
                                    isSelected
                                        ? colors.primary
                                        : colors.info,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Icon(
                                  tracks[index]['icon'],
                                  size: 32.sp,
                                  color: colors.primary,
                                ),
                              ],
                            ),

                            if (isSelected)
                              Positioned(
                                bottom: 4.h,
                                left: 0.w, // Changed to bottom-left to match screenshot
                                child: Container(
                                  padding: EdgeInsets.all(2.r),
                                  decoration: BoxDecoration(
                                    color: colors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.check, color: Colors.white, size: 14.sp),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        tracks[index]['label'],
                        style: text.labelSmall?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? colors.primary : colors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
