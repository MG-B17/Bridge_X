import 'package:bridge_x/core/animation/screen_transtion_animation/app_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends AppPageTransition {
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
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}