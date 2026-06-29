import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_error_widget.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_refresh_indicator.dart';
import 'package:bridge_x/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:bridge_x/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:bridge_x/features/notifications/presentation/widgets/notifications_list_widgets/notification_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<NotificationsCubit>().refreshNotifications();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.colors.scaffoldBg,
          elevation: 0,
          leading: Center(child: const BridgeXBackButton()),
          title: Text(
            AppStrings.notifications,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colors.ongoingText,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            BlocBuilder<NotificationsCubit, NotificationsState>(
              buildWhen: (previous, current) =>
                  previous.isActionLoading != current.isActionLoading,
              builder: (context, state) {
                return TextButton(
                  onPressed: state.isActionLoading
                      ? null
                      : () => context.read<NotificationsCubit>().markAllAsRead(),
                  child: Text(
                    AppStrings.markAllRead,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            const BridgeXBackgroundGears(icon: Icons.notifications),
            BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) => _buildBody(context, state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, NotificationsState state) {
    if (state is NotificationsLoading && state.notifications.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is NotificationsError && state.notifications.isEmpty) {
      return BridgeXErrorWidget(
        errorMessage: state.errorMessage ?? AppStrings.requestFailed,
        errorTittle: AppStrings.requestFailed,
        refreshButtonTap: () =>
            context.read<NotificationsCubit>().refreshNotifications(),
      );
    }

    if (state.notifications.isEmpty) {
      return BridgeXRefreshIndicator(
        onRefresh: () =>
            context.read<NotificationsCubit>().refreshNotifications(),
        color: context.colors.primary,
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            left: AppSpacing.spacing16,
            right: AppSpacing.spacing16,
            top: AppSpacing.spacing16,
            bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
          ),
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: Center(
                child: Text(
                  AppStrings.noNotifications,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return BridgeXRefreshIndicator(
      onRefresh: () =>
          context.read<NotificationsCubit>().refreshNotifications(),
      color: context.colors.primary,
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: AppSpacing.spacing16,
          right: AppSpacing.spacing16,
          top: AppSpacing.spacing16,
          bottom: AppSpacing.spacing16 + AppSpacing.spacing20,
        ),
        itemCount: state.notifications.length,
        separatorBuilder: (context, index) =>
            VerticalSpacing(AppSpacing.spacing16),
        itemBuilder: (context, index) {
          return NotificationItemTile(notification: state.notifications[index]);
        },
      ),
    );
  }
}
