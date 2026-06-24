import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';

class TaskSectionHeader extends StatelessWidget {
  const TaskSectionHeader({super.key, required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Text(
      '$title ($count)',
      style: AppTextStyles.titleLarge.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w700),
    );
  }
}
