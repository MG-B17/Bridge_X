import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/experience_level_selector.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/profile_quote.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/profile_setup_header.dart';
import 'package:bridge_x/feature/auth/presentation/screens/complete_profile/widget/track_selection_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Column(
              children: [
                const ProfileSetupHeader(),
                VerticalSpacing(AppSpacing.xxl),
                const TrackSelectionGrid(),
                VerticalSpacing(AppSpacing.xxl),
                const ExperienceLevelSelector(),
                VerticalSpacing(AppSpacing.xxl),
                const ProfileQuote(),
                VerticalSpacing(AppSpacing.xxl),
                BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                  builder: (context, state) {
                    return BridgeXButton(
                      text: AppStrings.continueText,
                      isLoading: state.isLoading,
                      onTap: state.selectedTrackIndex != -1
                          ? () => context.read<CompleteProfileCubit>().submitProfile()
                          : null,
                    );
                  },
                ),
                VerticalSpacing(AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
