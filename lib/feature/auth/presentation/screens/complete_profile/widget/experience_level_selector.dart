import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperienceLevelSelector extends StatelessWidget {
  const ExperienceLevelSelector({super.key});

  static List<String> get levels => AppStrings.experienceLevels;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.experienceLevel,
          style: text.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.lg),
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCardLarge),
            border: Border.all(color: colors.divider.withValues(alpha: 0.5)),
          ),
          child: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
            builder: (context, state) {
              return Row(
                children: levels.map((level) {
                  final isSelected = state.selectedExperience == level;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => context.read<CompleteProfileCubit>().selectExperience(level),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected ? colors.surface : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                          border: isSelected ? Border.all(color: colors.primary.withValues(alpha: 0.5)) : null,
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: colors.primary.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ] : null,
                        ),
                        child: Text(
                          level,
                          textAlign: TextAlign.center,
                          style: text.bodyMedium?.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? colors.primary : colors.textSecondary,
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
