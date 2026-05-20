import 'package:bridge_x/core/animation/screen_transtion_animation/app_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetTransitionPage extends AppPageTransition {
  final bool barrierDismissible;
  final Color barrierColor;

  BottomSheetTransitionPage({
    this.barrierDismissible = true,
    this.barrierColor = Colors.black54,
  });

  @override
  CustomTransitionPage build({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 750),
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      opaque: false,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      transitionsBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: child,
        );
      },
    );
  }
}