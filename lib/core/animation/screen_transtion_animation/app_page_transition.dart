import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppPageTransition {
  CustomTransitionPage build({
    required Widget child,
    required GoRouterState state,
    Duration duration,
  });
}
