import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagsSection extends StatelessWidget {
  const TagsSection({super.key, required this.tagController});

  final TextEditingController tagController;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.tags, style: AppTextStyles.titleMedium.copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600)),
        VerticalSpacing(AppSpacing.spacing8),
        BlocSelector<CreateTaskCubit, CreateTaskState, List<String>>(
          selector: (state) => state is CreateTaskReady ? state.tags : [],
          builder: (context, tags) {
            return Wrap(
              spacing: AppSpacing.spacing8,
              runSpacing: AppSpacing.spacing8,
              children: [
                ...tags.map((tag) => Chip(
                      label: Text(tag),
                      deleteIcon: Icon(Icons.close, size: 14.sp),
                      onDeleted: () => context.read<CreateTaskCubit>().removeTag(tag),
                      backgroundColor: colors.primary.withValues(alpha: 0.08),
                      side: BorderSide(color: colors.divider.withValues(alpha: 0.3)),
                      labelStyle: AppTextStyles.labelSmall.copyWith(color: colors.textPrimary),
                    )),
                GestureDetector(
                  onTap: () => _showAddTagDialog(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing12, vertical: AppSpacing.spacing8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSpacing.radiusPill), border: Border.all(color: colors.divider)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 14.sp, color: colors.textSecondary),
                        HorizontalSpacing(AppSpacing.spacing4),
                        Text(AppStrings.tag, style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showAddTagDialog(BuildContext context) {
    tagController.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.addTag),
        content: TextField(
          controller: tagController,
          autofocus: true,
          decoration: const InputDecoration(hintText: AppStrings.enterTagName),
          onSubmitted: (value) {
            context.read<CreateTaskCubit>().addTag(value.trim());
            Navigator.of(ctx).pop();
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text(AppStrings.cancel)),
          TextButton(
            onPressed: () {
              context.read<CreateTaskCubit>().addTag(tagController.text.trim());
              Navigator.of(ctx).pop();
            },
            child: const Text(AppStrings.add),
          ),
        ],
      ),
    );
  }
}
