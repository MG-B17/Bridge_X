import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/task_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/feature/task_management/presentation/bloc/create_task/create_task_state.dart';
import 'package:bridge_x/feature/task_management/presentation/widgets/create_task_widgets/priority_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTaskLabel extends StatelessWidget {
  const CreateTaskLabel({super.key, required this.text, this.isRequired = false});

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.titleMedium.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
        children: isRequired
            ? [TextSpan(text: ' *', style: AppTextStyles.titleMedium.copyWith(color: colors.error))]
            : null,
      ),
    );
  }
}

class TaskTitleField extends StatelessWidget {
  const TaskTitleField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CreateTaskLabel(text: AppStrings.taskTitle, isRequired: true),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(
          hint: AppStrings.taskTitleHint,
          controller: controller,
          validator: (v) => AppValidator.required(v, AppStrings.taskTitle),
        ),
      ],
    );
  }
}

class GitLinkField extends StatelessWidget {
  const GitLinkField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CreateTaskLabel(text: AppStrings.githubUrl, isRequired: true),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(
          hint: 'URL',
          controller: controller,
          prefixIcon: Icons.link,
          keyboardType: TextInputType.url,
          validator: AppValidator.url,
        ),
      ],
    );
  }
}

class TaskDescriptionField extends StatelessWidget {
  const TaskDescriptionField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CreateTaskLabel(text: AppStrings.taskDetails),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(
          hint: AppStrings.taskDetailsHint,
          controller: controller,
          maxLines: 5,
          minLines: 4,
          validator: (v) => AppValidator.required(v, AppStrings.taskDetails),
        ),
      ],
    );
  }
}

class DueDatePriorityRow extends StatelessWidget {
  const DueDatePriorityRow({
    super.key,
    required this.selectedDate,
    required this.onPickDate,
  });

  final DateTime? selectedDate;
  final VoidCallback onPickDate;

  static const _monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CreateTaskLabel(text: AppStrings.dueDate),
              VerticalSpacing(AppSpacing.spacing8),
              GestureDetector(
                onTap: onPickDate,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing12, vertical: AppSpacing.spacing14),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.divider),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                    color: colors.surface,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedDate != null
                              ? '${_monthNames[selectedDate!.month - 1]} ${selectedDate!.day}, ${selectedDate!.year}'
                              : AppStrings.selectDate,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: selectedDate != null ? colors.textPrimary : colors.textHint,
                          ),
                        ),
                      ),
                      Icon(Icons.calendar_today_outlined, size: 18.sp, color: colors.textHint),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        HorizontalSpacing(AppSpacing.spacing16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CreateTaskLabel(text: AppStrings.priority),
              VerticalSpacing(AppSpacing.spacing8),
              BlocSelector<CreateTaskCubit, CreateTaskState, int>(
                selector: (state) => state is CreateTaskReady ? state.priority : 2,
                builder: (context, priority) => PrioritySelector(selected: priority),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
