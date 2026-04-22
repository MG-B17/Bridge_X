import 'package:flutter/material.dart';
import 'package:bridgex/core/utils/extensions.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLoading({
    super.key,
    this.size = 40.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? context.colors.primary,
          ),
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
