import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:bridge_x/feature/notifications/presentation/cubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationBellButton extends StatelessWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (previous, current) =>
          previous.unreadCount != current.unreadCount,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await context.pushNamed(BridegeXRouteNames.notifications);
            if (!context.mounted) return;
            await context.read<NotificationsCubit>().fetchUnreadCount();
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: AppSpacing.iconBoxSize,
                height: AppSpacing.iconBoxSize,
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  shape: BoxShape.circle,
                  boxShadow: AppShadow.floating(context.colors.primary),
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: context.colors.primary,
                  size: AppSpacing.fontSize22,
                ),
              ),
              if (state.unreadCount > 0)
                Positioned(
                  top: -4,
                  right: -2,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.error,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: context.colors.surface,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        state.unreadCount > 99
                            ? '99+'
                            : state.unreadCount.toString(),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
