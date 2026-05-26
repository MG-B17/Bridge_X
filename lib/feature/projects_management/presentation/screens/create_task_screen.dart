import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_cubit.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/create_task/create_task_state.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/create_task_widgets/assign_to_section.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/create_task_widgets/create_task_form_fields.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/create_task_widgets/create_task_header.dart';
import 'package:bridge_x/feature/projects_management/presentation/widgets/create_task_widgets/tags_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key, required this.projectId});

  final int projectId;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _gitLinkController = TextEditingController();
  final _tagController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _gitLinkController.dispose();
    _tagController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocListener<CreateTaskCubit, CreateTaskState>(
      listener: _handleStateChange,
      child: Scaffold(
        backgroundColor: colors.surface,
        body: SafeArea(
          child: Column(
            children: [
              const CreateTaskHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpacing(AppSpacing.spacing16),
                        TaskTitleField(controller: _titleController),
                        VerticalSpacing(AppSpacing.spacing16),
                        GitLinkField(controller: _gitLinkController),
                        VerticalSpacing(AppSpacing.spacing16),
                        AssignToSection(searchController: _searchController),
                        VerticalSpacing(AppSpacing.spacing16),
                        TaskDescriptionField(controller: _descriptionController),
                        VerticalSpacing(AppSpacing.spacing16),
                        BlocSelector<CreateTaskCubit, CreateTaskState, DateTime?>(
                          selector: (state) => state is CreateTaskReady ? state.selectedDate : null,
                          builder: (context, date) => DueDatePriorityRow(selectedDate: date, onPickDate: _pickDate),
                        ),
                        VerticalSpacing(AppSpacing.spacing16),
                        TagsSection(tagController: _tagController),
                        VerticalSpacing(AppSpacing.spacing24),
                        BridgeXButton(text: AppStrings.createTask, onTap: _submit),
                        VerticalSpacing(AppSpacing.spacing20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(context: context, initialDate: now, firstDate: now, lastDate: now.add(const Duration(days: 365)));
    if (picked != null && mounted) context.read<CreateTaskCubit>().setDate(picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<CreateTaskCubit>();
    final state = cubit.state;
    if (state is! CreateTaskReady || state.selectedMemberId == null || state.selectedDate == null) return;
    final date = state.selectedDate!;
    cubit.submitTask(
      projectId: widget.projectId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      deadline: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      gitLink: _gitLinkController.text.trim().isNotEmpty ? _gitLinkController.text.trim() : null,
    );
  }

  void _handleStateChange(BuildContext context, CreateTaskState state) {
    if (state is CreateTaskLoading) {
      LoadingDialog.show(context: context, message: AppStrings.creatingTask);
    } else if (state is CreateTaskSuccess) {
      LoadingDialog.hide(context);
      SuccessDialog.show(context: context, title: AppStrings.taskCreated, message: AppStrings.taskCreatedMessage, onAction: () => context.pop());
    } else if (state is CreateTaskError) {
      LoadingDialog.hide(context);
      ErrorDialog.show(context: context, title: AppStrings.error, message: state.message);
    }
  }
}
