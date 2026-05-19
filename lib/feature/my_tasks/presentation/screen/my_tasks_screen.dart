import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../widget/my_tasks_widget/active_tasks_tab.dart';
import '../widget/my_tasks_widget/completed_tasks_tab.dart';
import '../widget/my_tasks_widget/my_tasks_tab_selector.dart';
import '../widget/my_tasks_widget/task_card.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  bool _isActiveTab = true;

  final List<TaskItem> _activeTasks = [
    TaskItem(
      id: '1',
      project: 'Project Orion',
      title: 'Refactor API Middleware',
      progress: 0.65,
      dueDate: 'Oct 24, 2024',
      status: TaskStatus.inProgress,
      description:
          'Optimize the existing middleware to reduce latency and improve error handling across all endpoints. Ensure that all legacy adapters are deprecated properly.',
      createdBy: 'Eman tweeg',
      creatorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      attachments: [
        TaskAttachment(name: 'API-Spec.pdf', size: '2.4 MB', dateAdded: 'Oct 12', isPdf: true),
        TaskAttachment(name: 'Middleware-Schema.png', size: '1.1 MB', dateAdded: 'Oct 14', isPdf: false),
      ],
    ),
    TaskItem(
      id: '2',
      project: 'Venus Portal',
      title: 'Design Checkout flow',
      progress: 0.30,
      dueDate: 'Nov 02, 2024',
      status: TaskStatus.pending,
      description:
          'Draft user experience mapping, high-fidelity UI layout interfaces, and configure core checkout integrations with payment microservices.',
      createdBy: 'Eman tweeg',
      creatorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      attachments: [],
    ),
    TaskItem(
      id: '3',
      project: 'Bridge X Platform',
      title: 'Optimize Database Indexing',
      progress: 0.90,
      dueDate: 'Oct 20, 2024',
      status: TaskStatus.nearCompletion,
      description:
          'Audit slow queries, introduce appropriate partition structures across logs, and scale primary indices for large workspace searches.',
      createdBy: 'Eman tweeg',
      creatorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      attachments: [],
    ),
  ];

  final List<TaskItem> _completedTasks = [
    TaskItem(
      id: '4',
      project: 'Ares Module',
      title: 'Setup CI/CD pipeline',
      progress: 1.0,
      dueDate: 'Oct 10, 2024',
      status: TaskStatus.completed,
      description:
          'Deploy GitHub actions, secure cloud repository environment parameters, configure automated fastlane deployments, and wire lint validation blocks.',
      createdBy: 'Eman tweeg',
      creatorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      attachments: [],
    ),
    TaskItem(
      id: '5',
      project: 'Core UI Kit',
      title: 'Implement Dark Theme support',
      progress: 1.0,
      dueDate: 'Oct 05, 2024',
      status: TaskStatus.completed,
      description:
          'Declare theme parameters inside dynamic context extensions, map colors to specific system tokens, and test system mode listeners.',
      createdBy: 'Eman tweeg',
      creatorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      attachments: [],
    ),
  ];

  List<TaskItem> _simulatedActiveTasks = [];

  @override
  void initState() {
    super.initState();
    _simulatedActiveTasks = List.from(_activeTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: Stack(
        children: [
          const BridgeXBackgroundGears(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BridgeXBackButton(),
                      Text(
                        AppStrings.myTasks,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalSpacing(AppSpacing.xs),
                      Text(
                        AppStrings.myTasksSubtitle,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                      VerticalSpacing(AppSpacing.lg),

                      MyTasksTabSelector(
                        isActiveTab: _isActiveTab,
                        onTabChanged: (val) {
                          setState(() => _isActiveTab = val);
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: _isActiveTab
                        ? ActiveTasksTab(
                            tasks: _simulatedActiveTasks,
                            onSimulateEmptyTap: () {
                              setState(() {
                                _simulatedActiveTasks.clear();
                              });
                            },
                          )
                        : CompletedTasksTab(tasks: _completedTasks),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
