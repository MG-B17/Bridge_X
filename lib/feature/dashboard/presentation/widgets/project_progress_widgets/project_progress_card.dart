import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/dashboard/domain/entities/project_detail_entity.dart';
import 'package:flutter/material.dart';

import 'project_progress_item.dart';

class ProjectProgressCard extends StatelessWidget {
  const ProjectProgressCard({
    super.key,
    required this.projects,
  });

  final List<ProjectDetailEntity> projects;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.spacing24),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius28),
        border: Border.all(
          color: context.colors.divider.withValues(alpha: 0.15),
          width: AppSpacing.width2,
        ),
        boxShadow: AppShadow.chartCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          projects.length,
          (index) => ProjectProgressItem(
            project: projects[index],
            isLast: index == projects.length - 1,
          ),
        ),
      ),
    );
  }
}
