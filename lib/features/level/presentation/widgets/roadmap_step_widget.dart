import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';
import 'roadmap_components.dart';

class RoadmapStepWidget extends StatelessWidget {
  final String title;
  final List<String> pills;
  final String activePill;
  final bool isCompleted;
  final bool isLocked;
  final bool showLine;

  const RoadmapStepWidget({
    super.key,
    required this.title,
    required this.pills,
    this.activePill = '',
    this.isCompleted = false,
    this.isLocked = false,
    this.showLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoadmapIndicator(
            isCompleted: isCompleted,
            isLocked: isLocked,
            showLine: showLine,
          ),
          HSpace(context.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context),
                VSpace(context.spacing.md),
                _buildPills(context),
                VSpace(context.spacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: context.labelSmall.copyWith(
        color: isLocked ? context.colors.textHint : context.colors.primary,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildPills(BuildContext context) {
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: pills.map((pill) => RoadmapPill(
        label: pill,
        isActive: pill == activePill,
        isLocked: isLocked,
      )).toList(),
    );
  }
}
