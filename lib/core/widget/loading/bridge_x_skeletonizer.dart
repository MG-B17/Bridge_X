import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BridgeXSkeletonizer extends StatelessWidget {
  const BridgeXSkeletonizer({super.key, required this.child, required this.enableloading});
  final Widget child;
  final bool enableloading;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enableloading,
      ignoreContainers: true,
      effect: const ShimmerEffect(),
      child: child,
    );
  }
}
