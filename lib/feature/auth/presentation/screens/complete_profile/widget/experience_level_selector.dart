import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExperienceLevelSelector extends StatelessWidget {
  const ExperienceLevelSelector({super.key});

  static List<String> get levels => AppStrings.experienceLevels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          AppStrings.experienceLevel,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
          ),
        ),
        SizedBox(height: 16.h),
        // Outer container pill
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(
              color: AppColors.lightGray.withValues(alpha: 0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
            builder: (context, state) {
              return Row(
                children: levels.map((level) {
                  final isSelected = state.selectedExperience == level;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => context
                          .read<CompleteProfileCubit>()
                          .selectExperience(level),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(50.r),
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.primaryBlue,
                                  width: 2,
                                )
                              : null,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primaryBlue
                                        .withValues(alpha: 0.18),
                                    blurRadius: 16,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          level,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? AppColors.navyBlue
                                : AppColors.gray,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
