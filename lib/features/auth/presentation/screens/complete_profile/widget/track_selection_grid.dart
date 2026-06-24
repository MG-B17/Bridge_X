import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/auth/presentation/controller/complete_profile/complete_profile_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/complete_profile/complete_profile_state.dart';
import 'package:bridge_x/features/auth/utils/auth_tracks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackSelectionGrid extends StatelessWidget {
  const TrackSelectionGrid({super.key});

  static const Map<String, IconData> _trackIcons = {
    'Frontend': Icons.computer_outlined,
    'UI/UX': Icons.design_services_outlined,
    'DevOps': Icons.sync_alt_outlined,
    'Data science': Icons.hub_outlined,
    'Backend': Icons.storage_outlined,
    'AI': Icons.psychology_outlined,
    'Mobile': Icons.smartphone_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.selectTrack,
              style: GoogleFonts.inter(
                fontSize: AppSpacing.fontSize18,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing12,
                vertical: AppSpacing.height4,
              ),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radius20),
                border: Border.all(
                  color: context.colors.primary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                AppStrings.required,
                style: GoogleFonts.inter(
                  fontSize: AppSpacing.fontSize12,
                  fontWeight: FontWeight.w600,
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.height20),
        BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
          buildWhen: (p, c) => p.selectedTrackIndex != c.selectedTrackIndex,
          builder: (context, state) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSpacing.height24,
                crossAxisSpacing: AppSpacing.spacing16,
                childAspectRatio: 0.82,
              ),
              itemCount: AuthTracks.count,
              itemBuilder: (context, index) {
                final label = AuthTracks.labels[index];
                final isSelected = state.selectedTrackIndex == index;
                return GestureDetector(
                  onTap: () =>
                      context.read<CompleteProfileCubit>().selectTrack(index),
                  child: _TrackCard(
                    label: label,
                    icon: _trackIcons[label] ?? Icons.circle_outlined,
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
            Container(
              width: AppSpacing.width80,
              height: AppSpacing.width80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.surface,
                border: Border.all(
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.primary.withValues(
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
                  SvgPicture.asset(
                    'assets/svgs/track_selection_background.svg',
                    width: AppSpacing.width80,
                    height: AppSpacing.width80,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? context.colors.primary.withValues(alpha: 0.15)
                          : context.colors.primaryLight.withValues(alpha: 0.6),
                      BlendMode.srcIn,
                    ),
                  ),
                  Icon(
                    icon,
                    size: AppSpacing.fontSize30,
                    color: context.colors.primary,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: AppSpacing.spacing20,
                  height: AppSpacing.spacing20,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: context.colors.surface,
                    size: AppSpacing.fontSize12,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: AppSpacing.height8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: AppSpacing.fontSize12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? context.colors.primary : context.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
