import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationBellButton extends StatelessWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(BridegeXRouteNames.notifications),
      child: Container(
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
    );
  }
}
