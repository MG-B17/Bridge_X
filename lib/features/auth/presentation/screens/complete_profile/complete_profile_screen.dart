import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_names.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/models/user_data_model.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/auth/presentation/controller/complete_profile/complete_profile_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/complete_profile/complete_profile_state.dart';
import 'package:bridge_x/features/auth/presentation/screens/complete_profile/widget/experience_level_selector.dart';
import 'package:bridge_x/features/auth/presentation/screens/complete_profile/widget/profile_quote.dart';
import 'package:bridge_x/features/auth/presentation/screens/complete_profile/widget/profile_setup_header.dart';
import 'package:bridge_x/features/auth/presentation/screens/complete_profile/widget/track_selection_grid.dart';
import 'package:bridge_x/features/auth/utils/auth_strings.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> _persistUserData() async {
  final userData = sl<AppState>().userData;
  if (userData != null) {
    await sl<SecureStorageService>().write(
      key: AppKeys.userDataKey,
      value: UserDataModel.userEncodedata(userDataModel: userData),
    );
  }
}

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CompleteProfileCubit>(),
      child: BlocListener<CompleteProfileCubit, CompleteProfileState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == AuthStatus.loading) {
            LoadingDialog.show(context: context, message: AuthStrings.completingProfile);
          } else if (state.status == AuthStatus.success) {
            unawaited(_persistUserData());
            context.goNamed(BridgeXRouteNames.updateProfile);
          } else if (state.status == AuthStatus.error) {
            LoadingDialog.hide(context);
            ErrorDialog.show(
              context: context,
              title: AuthStrings.profileSetupFailed,
              message: state.message ?? AppFeedbackMessages.genericError,
            );
          }
        },
        child: PopScope(
          canPop: false,
          child: Scaffold(
          backgroundColor: context.colors.scaffoldBg,
          body: Stack(
            children: [
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
                      BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                        buildWhen: (p, c) => p.selectedTrackIndex != c.selectedTrackIndex,
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
                                duration: AppSpacing.animationNormal,
                                opacity: isEnabled ? 1.0 : 0.4,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.continueText,
                                      style: GoogleFonts.inter(
                                        fontSize: AppSpacing.fontSize18,
                                        fontWeight: FontWeight.bold,
                                        color: context.colors.primary,
                                      ),
                                    ),
                                    SizedBox(width: AppSpacing.spacing6),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: context.colors.primary,
                                      size: AppSpacing.fontSize24,
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
        ),
      ),
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const svgPath = 'assets/svgs/track_selection_background.svg';

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: AppSpacing.height60,
            left: -AppSpacing.spacing10,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width120),
          ),
          Positioned(
            top: AppSpacing.height60,
            right: -AppSpacing.spacing10,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width100),
          ),
          Positioned(
            top: AppSpacing.height200,
            left: AppSpacing.width50,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width90),
          ),
          Positioned(
            top: AppSpacing.height350,
            right: AppSpacing.spacing20,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width110),
          ),
          Positioned(
            top: AppSpacing.height450,
            left: -AppSpacing.spacing15,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width100),
          ),
          Positioned(
            top: AppSpacing.height580,
            right: -AppSpacing.spacing10,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width95),
          ),
          Positioned(
            top: AppSpacing.height700,
            left: AppSpacing.spacing30,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width80),
          ),
          Positioned(
            top: AppSpacing.height800,
            right: AppSpacing.spacing30,
            child: _buildBlob(svgPath, context.colors.primary, AppSpacing.width85),
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
