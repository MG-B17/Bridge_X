import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/controller/complete_profile/complete_profile_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/complete_profile/complete_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ExperienceLevelSelector extends StatelessWidget {
  const ExperienceLevelSelector({super.key});

  static List<String> get levels => AppStrings.experienceLevels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.experienceLevel,
          style: GoogleFonts.inter(
            fontSize: AppSpacing.fontSize18,
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.height16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.radius6),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            border: Border.all(
              color: context.colors.divider.withValues(alpha: 0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: context.colors.primary.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
            buildWhen: (p, c) => p.selectedExperience != c.selectedExperience,
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
                        duration: AppSpacing.animationNormal,
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.height14),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? context.colors.surface : context.colors.transparent,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                          border: isSelected
                              ? Border.all(
                                  color: context.colors.primary,
                                  width: 2,
                                )
                              : null,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: context.colors.primary
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
                            fontSize: AppSpacing.fontSize14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? context.colors.textPrimary
                                : context.colors.textSecondary,
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
