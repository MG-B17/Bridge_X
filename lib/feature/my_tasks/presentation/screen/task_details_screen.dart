import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_background_gears.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../widget/my_tasks_widget/task_card.dart';
import '../widget/task_details_widget/task_attachment_card.dart';
import '../widget/task_details_widget/task_detail_field.dart';
import '../widget/task_details_widget/task_details_header_card.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, this.task});

  final TaskItem? task;

  @override
  Widget build(BuildContext context) {
    final taskItem = task ??
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
        );

    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: Stack(
        children: [
          const BridgeXBackgroundGears(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      const BridgeXBackButton(),
                      const Spacer(),
                      Text(
                        AppStrings.taskDetails,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      HorizontalSpacing(40.w),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskDetailsHeaderCard(task: taskItem),
                        VerticalSpacing(AppSpacing.lg),

                        TaskDetailField(
                          label: AppStrings.description,
                          child: Text(
                            taskItem.description,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                        VerticalSpacing(AppSpacing.lg),

                        TaskDetailField(
                          label: AppStrings.dueDate,
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: context.colors.primary,
                                size: 20.sp,
                              ),
                              HorizontalSpacing(AppSpacing.sm),
                              Text(
                                taskItem.dueDate,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(AppSpacing.lg),

                        TaskDetailField(
                          label: AppStrings.createdBy,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16.r,
                                backgroundImage: taskItem.creatorAvatar.isNotEmpty
                                    ? NetworkImage(taskItem.creatorAvatar)
                                    : null,
                                child: taskItem.creatorAvatar.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              HorizontalSpacing(AppSpacing.sm),
                              Text(
                                taskItem.createdBy,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalSpacing(AppSpacing.lg),

                        if (taskItem.attachments.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                            child: Text(
                              AppStrings.attachments.toUpperCase(),
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: taskItem.attachments.length,
                            separatorBuilder: (context, index) => VerticalSpacing(AppSpacing.sm),
                            itemBuilder: (context, index) {
                              final attachment = taskItem.attachments[index];
                              return TaskAttachmentCard(attachment: attachment);
                            },
                          ),
                          VerticalSpacing(AppSpacing.xl),
                        ],

                        BridgeXButton(
                          text: AppStrings.updateProgress,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        VerticalSpacing(AppSpacing.xl),
                      ],
                    ),
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
