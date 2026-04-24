import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/my_tasks_tab_selector.dart';
import '../widgets/task_progress_card.dart';
import '../widgets/completed_tasks_content.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScreenHeader(context),
            VSpace(context.spacing.lg),
            MyTasksTabSelector(
              selectedIndex: _selectedTab,
              onTabChanged: (index) {
                setState(() => _selectedTab = index);
              },
            ),
            VSpace(context.spacing.xl),
            _selectedTab == 0
                ? _buildActiveTasksList()
                : const CompletedTasksContent(),
            VSpace(context.spacing.xxl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _buildScreenHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.myTasks,
          style: context.displayLarge.copyWith(
            color: context.colors.textPrimary,
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        VSpace(context.spacing.xs),
        Text(
          AppStrings.myTasksSubtitle,
          style: context.bodyMedium.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveTasksList() {
    return Column(
      children: [
        TaskProgressCard(
          projectName: 'Project Orion',
          taskTitle: 'Refactor API Middleware',
          status: TaskStatus.inProgress,
          progressValue: 0.65,
          dueDate: 'Due Oct 24',
          onTap: () => context.push(AppRouteConstant.taskDetails),
        ),
        TaskProgressCard(
          projectName: 'Design System',
          taskTitle: 'Finalize Color Tokens',
          status: TaskStatus.pending,
          progressValue: 0.12,
          dueDate: 'Due Oct 26',
          onTap: () => context.push(AppRouteConstant.taskDetails),
        ),
        TaskProgressCard(
          projectName: 'Team Up App',
          taskTitle: 'Push Notifications Setup',
          status: TaskStatus.nearCompletion,
          progressValue: 0.92,
          dueDate: 'Due Oct 22',
          onTap: () => context.push(AppRouteConstant.taskDetails),
        ),
      ],
    );
  }
}

