import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/task_details_widgets.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TaskDetailsBanner(
                    taskTitle: 'Refactor API Middleware',
                    statusLabel: AppStrings.inProgress,
                    priorityLabel: AppStrings.high,
                  ),
                  VSpace(context.spacing.xxl),
                  const TaskDescriptionCard(
                    description:
                        'Optimize the existing middleware to reduce latency and improve error handling across all endpoints. Ensure that all legacy adapters are deprecated properly.',
                  ),
                  VSpace(context.spacing.lg),
                  const TaskDueDateCard(date: 'Oct 24, 2024'),
                  VSpace(context.spacing.lg),
                  const TaskCreatedByCard(
                    name: 'Eman tweeg',
                    avatarUrl: 'https://i.pravatar.cc/150?u=eman',
                  ),
                  VSpace(context.spacing.xxl),
                  _buildAttachments(context),
                  VSpace(context.spacing.xxl),
                ],
              ),
            ),
          ),
          _buildBottomAction(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
        onPressed: () => context.pop(),
      ),
      title: Text(
        AppStrings.taskDetails,
        style: context.titleLarge.copyWith(
          color: context.colors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildAttachments(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.attachments.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        VSpace(context.spacing.md),
        const TaskAttachmentItem(
          fileName: 'API-Spec.pdf',
          fileSize: '2.4 MB',
          addedDate: 'Added Oct 12',
          icon: Icons.picture_as_pdf_rounded,
          iconColor: Color(0xFFEF4444),
          iconBgColor: Color(0xFFFEF2F2),
        ),
        const TaskAttachmentItem(
          fileName: 'Middleware-Schema.png',
          fileSize: '1.1 MB',
          addedDate: 'Added Oct 14',
          icon: Icons.image_outlined,
          iconColor: Color(0xFF3B82F6),
          iconBgColor: Color(0xFFEFF6FF),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xl),
      decoration: BoxDecoration(
        color: context.colors.scaffoldBg,
      ),
      child: SafeArea(
        top: false,
        child: AppButton(
          label: AppStrings.updateProgress,
          onPressed: () {},
        ),
      ),
    );
  }
}
