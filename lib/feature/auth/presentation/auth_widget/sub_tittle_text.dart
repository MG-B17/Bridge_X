import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SubTittleText extends StatelessWidget {
  const SubTittleText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textSecondary),
    );
  }
}
