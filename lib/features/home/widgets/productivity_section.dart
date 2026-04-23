import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/utils/extensions.dart';
import 'circular_productivity_chart.dart';
import 'project_bar_chart.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Productivity',
          style: context.displayLarge.copyWith(
            color: context.colors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        VSpace(context.spacing.md),
        const CircularProductivityChart(),
        VSpace(context.spacing.md),
        const ProjectBarChart(),
      ],
    );
  }
}
