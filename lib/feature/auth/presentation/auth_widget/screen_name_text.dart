import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ScreenNameText extends StatelessWidget {
  const ScreenNameText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colors.secondary,
      ),
    );
  }
}
