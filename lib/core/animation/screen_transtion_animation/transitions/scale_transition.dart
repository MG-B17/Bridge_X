import 'package:bridge_x/core/animation/screen_transtion_animation/app_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaleTransitionPage extends AppPageTransition {
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
      transitionsBuilder: (_, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );

        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.9,
            end: 1,
          ).animate(curved),
          child: FadeTransition(
            opacity: curved,
            child: child,
          ),
        );
      },
    );
  }
}