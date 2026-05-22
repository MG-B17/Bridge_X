import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../data/model/project_model.dart';
import 'add_project_form.dart';
import 'project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final List<ProjectItem> _projects = [
    ProjectItem(name: 'Nova Dashboards', role: 'Lead Product Designer'),
  ];

  bool _isAddingProject = false;
  final _projectNameController = TextEditingController();
  final _roleController = TextEditingController();

  @override
  void dispose() {
    _projectNameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _addNewProject() {
    if (_projectNameController.text.trim().isNotEmpty &&
        _roleController.text.trim().isNotEmpty) {
      setState(() {
        _projects.add(
          ProjectItem(
            name: _projectNameController.text.trim(),
            role: _roleController.text.trim(),
          ),
        );
        _projectNameController.clear();
        _roleController.clear();
        _isAddingProject = false;
      });
    }
  }

  void _removeProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.projects,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isAddingProject = true;
                });
              },
              child: Row(
                children: [
                  Icon(Icons.add, color: context.colors.primary, size: 18.sp),
                  HorizontalSpacing(AppSpacing.spacing4),
                  Text(
                    AppStrings.addProject,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing8),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _projects.length,
          separatorBuilder: (context, index) => VerticalSpacing(AppSpacing.spacing8),
          itemBuilder: (context, index) {
            final project = _projects[index];
            return ProjectCard(
              project: project,
              onDelete: () => _removeProject(index),
            );
          },
        ),

        if (_isAddingProject) ...[
          VerticalSpacing(AppSpacing.spacing8),
          AddProjectForm(
            projectNameController: _projectNameController,
            roleController: _roleController,
            onConfirm: _addNewProject,
            onCancel: () {
              setState(() {
                _projectNameController.clear();
                _roleController.clear();
                _isAddingProject = false;
              });
            },
          ),
        ],
      ],
    );
  }
}
