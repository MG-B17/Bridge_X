import 'package:flutter/material.dart';

import '../../../../core/theme/bridge_x_colors.dart';

class DayIndicator extends StatelessWidget {
  final String day;

  const DayIndicator({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        decoration: BoxDecoration(
          color: AppColors.today,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          day,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.gray,
          ),
        ),
      ),
    );
  }
}
