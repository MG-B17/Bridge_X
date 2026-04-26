import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../widgets/projects_filter_chips.dart';
import '../widgets/projects_empty_graphic.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String _selectedFilter = 'Ongoing';

  @override
  Widget build(BuildContext context) {
    // Mock data for projects
    final List<Map<String, dynamic>> allProjects = [
      {
        'title': 'FinTrack Mobile Pro',
        'status': 'Ongoing',
        'role': 'Role: Frontend Dev',
        'progress': 0.6,
        'icon': Icons.phone_iphone,
        'avatars': ['https://i.pravatar.cc/150?u=1', 'https://i.pravatar.cc/150?u=2'],
        'extraAvatars': 3,
      },
      {
        'title': 'Graphic Design',
        'status': 'Ongoing',
        'role': 'Role: Backend Dev',
        'progress': 0.4,
        'icon': Icons.phone_iphone,
        'avatars': ['https://i.pravatar.cc/150?u=3', 'https://i.pravatar.cc/150?u=4'],
        'extraAvatars': 3,
      },
      {
        'title': 'Quantum Dashboard Redesign',
        'status': 'Ongoing',
        'role': 'Development Phase',
        'progress': 0.7,
        'progressPhase': 'Development Phase',
        'isYourTeam': true,
        'avatars': ['https://i.pravatar.cc/150?u=5', 'https://i.pravatar.cc/150?u=6', 'https://i.pravatar.cc/150?u=7'],
      },
      {
        'title': 'Q3 Marketing Audit',
        'status': 'Completed',
        'role': 'Comprehensive analysis of seasonal campaign performance and ROI metrics for the global...',
        'finishedDate': 'Nov 04, 2023',
        'actionText': 'View Report',
      },
      {
        'title': 'API Gateway Overhaul',
        'status': 'Completed',
        'categoryLabel': 'Infrastructure',
        'role': 'Transitioning legacy monolithic endpoints to a modern serverless architecture with improved latency and security protocols across all regions.',
        'finishedDate': 'Nov 04, 2023',
        'actionText': 'View Report',
      },
      {
        'title': 'Brand Refresh 2024',
        'status': 'Completed',
        'role': 'Complete overhaul of visual identity, typography, and voice for the upcoming...',
        'finishedDate': 'Nov 04, 2023',
        'actionText': 'View Report',
      },
      {
        'title': 'Mobile App v2.0',
        'status': 'Completed',
        'role': 'The most significant update to our core product yet, focusing on user experience and accessibility features across iOS and Android.',
        'finishedDate': 'Nov 04, 2023',
        'actionText': 'View Report',
      },
    ];

    final filteredProjects = _selectedFilter == 'All'
        ? allProjects
        : allProjects.where((p) => p['status'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Projects',
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.colors.primary,
                ),
              ),
              VSpace(context.spacing.xs),
              Text(
                'Manage and track your collaboration progress',
                style: context.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              VSpace(context.spacing.lg),
              
              ProjectsFilterChips(
                selectedFilter: _selectedFilter,
                onSelected: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
              ),
              
              VSpace(context.spacing.xl),
              
              if (filteredProjects.isEmpty) ...[
                AppButton(
                  label: '+ Create Project',
                  onPressed: () => context.push(AppRouteConstant.createTeam),
                ),
                VSpace(context.spacing.xxl),
                const ProjectsEmptyGraphic(),
                VSpace(context.spacing.lg),
                Center(
                  child: Text(
                    'No projects yet',
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
                VSpace(context.spacing.sm),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
                    child: Text(
                      'Start your first project or join an existing team to begin your journey.',
                      textAlign: TextAlign.center,
                      style: context.bodyLarge.copyWith(
                        color: context.colors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                VSpace(context.spacing.xxl),
                AppButton(
                  label: 'Explore Public Teams',
                  trailing: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  onPressed: () => context.push(AppRouteConstant.teams),
                ),
                VSpace(context.spacing.md),
                _buildSecondaryButton(context),
                VSpace(context.spacing.xxl),
                _buildBottomSocialProof(context),
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    final project = filteredProjects[index];
                    return ProjectCard(
                      title: project['title'],
                      status: project['status'],
                      role: project['role'],
                      categoryLabel: project['categoryLabel'],
                      progress: project['progress'],
                      progressPhase: project['progressPhase'],
                      icon: project['icon'],
                      avatars: project['avatars'] ?? [],
                      extraAvatars: project['extraAvatars'],
                      isYourTeam: project['isYourTeam'] ?? false,
                      rating: project['rating'],
                      finishedDate: project['finishedDate'],
                      actionText: project['actionText'],
                      onActionTap: () {
                        if (project['title'] == 'Quantum Dashboard Redesign') {
                          context.push(AppRouteConstant.mentorProjectDetails);
                        } else {
                          context.push(AppRouteConstant.projectDetails);
                        }
                      },
                    );
                  },
                ),
              ],
              VSpace(context.spacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return Container(
      height: 52.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          onTap: () => context.push(AppRouteConstant.createTeam),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.rocket_launch, color: context.colors.textPrimary, size: 20.r),
              HSpace(context.spacing.sm),
              Text(
                'Create Team',
                style: context.bodyLarge.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSocialProof(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.w,
          height: 30.r,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: context.colors.textHint.withValues(alpha: 0.2),
                ),
              ),
              Positioned(
                left: 20.w,
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: context.colors.textHint.withValues(alpha: 0.3),
                ),
              ),
              Positioned(
                left: 40.w,
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: context.colors.textHint.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        HSpace(context.spacing.sm),
        Text(
          'Join 5,000+ active teams today',
          style: context.labelSmall.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
