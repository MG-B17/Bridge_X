import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/project_filter_tabs.dart';
import '../widgets/projects_empty_state.dart';
import '../widgets/projects_header.dart';
import '../widgets/projects_list_content.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int _selectedFilter = 0;

  final bool _hasProjects = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProjectsHeader(),
              VerticalSpacing(AppSpacing.md),
              ProjectFilterTabs(
                selectedIndex: _selectedFilter,
                onChanged: (i) => setState(() => _selectedFilter = i),
              ),
              VerticalSpacing(AppSpacing.md),
              if (_hasProjects)
                ProjectsListContent(selectedFilter: _selectedFilter)
              else
                ProjectsEmptyState(
                  onExploreTeams: () {
                    // TODO: Navigate to explore public teams
                  },
                  onCreateTeam: () {
                    context.pushNamed(BridegeXRouteNames.createTeam);
                  },
                ),

              VerticalSpacing(AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
