import 'package:flutter/material.dart';

class BridgeXRefreshIndicator extends StatelessWidget {
  const BridgeXRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    required this.color,
    this.backgroundColor
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final Color color; 
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
