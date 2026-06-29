import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
import 'package:bridge_x/features/invitaions/presentation/cubit/invitaions_cubit.dart';
import 'package:bridge_x/features/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/info_box.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/requests_center_widgets/requests_center_header.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/requests_center_widgets/requests_center_list_content.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/requests_center_widgets/requests_center_loading_list.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/requests_center_widgets/requests_center_section_title.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/requests_center_widgets/requests_center_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsCenterScreen extends StatefulWidget {
  const RequestsCenterScreen({super.key});

  @override
  State<RequestsCenterScreen> createState() => _RequestsCenterScreenState();
}

class _RequestsCenterScreenState extends State<RequestsCenterScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvitaionsCubit>(
      create: (context) => sl<InvitaionsCubit>()..loadData(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<InvitaionsCubit, InvitaionsState>(
            listener: (context, state) {
              if (state is InvitaionsLoaded && state.actionError != null) {
                ErrorDialog.show(
                  context: context,
                  title: 'Action Failed',
                  message: state.actionError!,
                );
              }
            },
            builder: (context, state) {
              if (state is InvitaionsError) {
                return BridgeXErrorWidget(
                  errorMessage: state.message,
                  errorTittle: 'Failed to Load Requests',
                  refreshButtonTap: () => context.read<InvitaionsCubit>().loadData(),
                );
              }

              final isLoading = state is InvitaionsInitial || state is InvitaionsLoading;
              final loadedState = state is InvitaionsLoaded ? state : null;
              final invitations = loadedState?.invitations ?? [];
              final joinRequests = loadedState?.joinRequests ?? [];
              final activeTab = loadedState?.activeTab ?? InvitaionsTab.invitations;

              return BridgeXRefreshIndicator(
                onRefresh: () async {
                  await context.read<InvitaionsCubit>().loadData();
                },
                color: context.appColors.primary,
                child: ScrollNavListener(
                  controller: _scrollController,
                  child: BridgeXSkeletonizer(
                    enableloading: isLoading,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.spacing20,
                        vertical: AppSpacing.spacing20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const RequestsCenterHeader(),
                          VerticalSpacing(AppSpacing.spacing24),
                          RequestsCenterTabs(
                            isLoading: isLoading,
                            invitationsCount: invitations.length,
                            joinRequestsCount: joinRequests.length,
                            activeTab: activeTab,
                            onTabChanged: (tab) {
                              if (!isLoading) {
                                context.read<InvitaionsCubit>().switchTab(tab);
                              }
                            },
                          ),
                          VerticalSpacing(AppSpacing.spacing24),
                          RequestsCenterSectionTitle(activeTab: activeTab),
                          VerticalSpacing(AppSpacing.spacing12),
                          if (isLoading)
                            const RequestsCenterLoadingList(),
                          if (!isLoading)
                            RequestsCenterListContent(
                              activeTab: activeTab,
                              invitations: invitations,
                              joinRequests: joinRequests,
                              cubit: context.read<InvitaionsCubit>(),
                            ),
                          VerticalSpacing(AppSpacing.spacing8),
                          const InfoBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
