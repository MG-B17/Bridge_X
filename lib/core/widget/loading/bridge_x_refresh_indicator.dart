import 'package:flutter/material.dart';

class BridgeXRefreshIndicator extends StatelessWidget {
  const BridgeXRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    required this.color,
    this.backgroundColor,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final Color color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    // Automatically hide shadow (elevation) and stroke when the color is transparent
    final bool isTransparent = color == Colors.transparent || color.a == 0.0;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color,
      backgroundColor: backgroundColor,
      elevation: isTransparent ? 0.0 : 2.0,
      strokeWidth: isTransparent ? 0.0 : RefreshProgressIndicator.defaultStrokeWidth,
      child: child,
    );
  }
}

