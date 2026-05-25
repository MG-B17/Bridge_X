import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/widget/feedback/loading_dialog.dart';
import 'package:bridge_x/core/widget/feedback/success_dialog.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/create_task/presentation/cubit/create_task_cubit.dart';
import 'package:bridge_x/feature/create_task/presentation/cubit/create_task_state.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/dashboard/team_member_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  DateTime? _selectedDate;

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
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpacing(AppSpacing.spacing16),
                        _buildTitleField(),
                        VerticalSpacing(AppSpacing.spacing16),
                        _buildGitLinkField(),
                        VerticalSpacing(AppSpacing.spacing16),
                        _buildAssignToSection(),
                        VerticalSpacing(AppSpacing.spacing16),
                        _buildDescriptionField(),
                        VerticalSpacing(AppSpacing.spacing16),
                        _buildDateAndPriorityRow(),
                        VerticalSpacing(AppSpacing.spacing16),
                        _buildTagsSection(),
                        VerticalSpacing(AppSpacing.spacing24),
                        _buildSubmitButton(),
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

  Widget _buildHeader(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: AppSpacing.spacing12,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.close, color: colors.textPrimary, size: 24.sp),
          ),
          const Spacer(),
          Text(
            AppStrings.createTask,
            style: AppTextStyles.headlineSmall.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          SizedBox(width: 24.sp),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Task Title', isRequired: true),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(
          hint: 'e.g. Implement OAuth2 flow',
          controller: _titleController,
          validator: (v) => AppValidator.required(v, 'Task Title'),
        ),
      ],
    );
  }

  Widget _buildGitLinkField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Github URL', isRequired: true),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(
          hint: 'URL',
          controller: _gitLinkController,
          prefixIcon: Icons.link,
          keyboardType: TextInputType.url,
          validator: AppValidator.url,
        ),
      ],
    );
  }

  Widget _buildAssignToSection() {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildLabel('Assign To', isRequired: true),
            const Spacer(),
            Text(
              'View All',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(
          hint: 'Search team members...',
          controller: _searchController,
          prefixIcon: Icons.search,
        ),
        VerticalSpacing(AppSpacing.spacing12),
        BlocSelector<CreateTaskCubit, CreateTaskState, _MembersData>(
          selector: (state) {
            if (state is CreateTaskReady) {
              return _MembersData(state.members, state.selectedMemberId);
            }
            return const _MembersData([], null);
          },
          builder: (context, data) {
            return SizedBox(
              height: AppSpacing.spacing75,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.members.length + 1,
                separatorBuilder: (context, index) => HorizontalSpacing(AppSpacing.spacing16),
                itemBuilder: (context, index) {
                  if (index == data.members.length) {
                    return _buildAddMemberButton();
                  }
                  return _buildMemberAvatar(
                    data.members[index],
                    isSelected: data.selectedId == data.members[index].programmerId,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMemberAvatar(TeamMemberEntity member, {required bool isSelected}) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => context.read<CreateTaskCubit>().selectMember(member.programmerId),
      child: SizedBox(
        width: 60.w,
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: colors.divider,
                  backgroundImage: member.avatarUrl != null
                      ? NetworkImage(member.avatarUrl!)
                      : null,
                  child: member.avatarUrl == null
                      ? Icon(Icons.person, size: 24.sp, color: colors.textHint)
                      : null,
                ),
                if (isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.surface, width: 2),
                      ),
                      child: Icon(Icons.check, size: 10.sp, color: colors.surface),
                    ),
                  ),
              ],
            ),
            VerticalSpacing(AppSpacing.spacing4),
            Text(
              _shortenName(member.name),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? colors.primary : colors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMemberButton() {
    final colors = context.colors;
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: colors.primary.withValues(alpha: 0.1),
            child: Icon(Icons.add, size: 24.sp, color: colors.primary),
          ),
          VerticalSpacing(AppSpacing.spacing4),
          Text(
            'Add',
            style: AppTextStyles.labelSmall.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Task Details'),
        VerticalSpacing(AppSpacing.spacing8),
        BridgeXTextFormField(
          hint: 'Describe what needs to be done...',
          controller: _descriptionController,
          maxLines: 5,
          minLines: 4,
          validator: (v) => AppValidator.required(v, 'Description'),
        ),
      ],
    );
  }

  Widget _buildDateAndPriorityRow() {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Due Date'),
              VerticalSpacing(AppSpacing.spacing8),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing12,
                    vertical: AppSpacing.spacing14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.divider),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                    color: colors.surface,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate != null
                              ? '${_monthNames[_selectedDate!.month - 1]} ${_selectedDate!.day}, ${_selectedDate!.year}'
                              : 'Select date',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: _selectedDate != null
                                ? colors.textPrimary
                                : colors.textHint,
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
              _buildLabel('Priority'),
              VerticalSpacing(AppSpacing.spacing8),
              BlocSelector<CreateTaskCubit, CreateTaskState, int>(
                selector: (state) => state is CreateTaskReady ? state.priority : 2,
                builder: (context, priority) => _buildPriorityChips(priority),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityChips(int selected) {
    final colors = context.colors;
    return Row(
      children: [
        _buildChip('LOW', 1, selected, colors),
        HorizontalSpacing(AppSpacing.spacing6),
        _buildChip('MED', 2, selected, colors),
        HorizontalSpacing(AppSpacing.spacing6),
        _buildChip('HIGH', 3, selected, colors),
      ],
    );
  }

  Widget _buildChip(String label, int value, int selected, dynamic colors) {
    final isSelected = value == selected;
    return GestureDetector(
      onTap: () => context.read<CreateTaskCubit>().setPriority(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing12,
          vertical: AppSpacing.spacing8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? colors.secondary : colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(
            color: isSelected ? colors.secondary : colors.divider,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isSelected ? colors.surface : colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Tags'),
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
                      labelStyle: AppTextStyles.labelSmall.copyWith(
                        color: colors.textPrimary,
                      ),
                    )),
                GestureDetector(
                  onTap: _showAddTagDialog,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing12,
                      vertical: AppSpacing.spacing8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                      border: Border.all(color: colors.divider),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 14.sp, color: colors.textSecondary),
                        HorizontalSpacing(AppSpacing.spacing4),
                        Text(
                          'Tag',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
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

  Widget _buildSubmitButton() {
    return BridgeXButton(
      text: AppStrings.createTask,
      onTap: _submit,
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    final colors = context.colors;
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.titleMedium.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: AppTextStyles.titleMedium.copyWith(color: colors.error),
                ),
              ]
            : null,
      ),
    );
  }

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showAddTagDialog() {
    _tagController.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Tag'),
        content: TextField(
          controller: _tagController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter tag name'),
          onSubmitted: (value) {
            context.read<CreateTaskCubit>().addTag(value.trim());
            Navigator.of(ctx).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CreateTaskCubit>().addTag(_tagController.text.trim());
              Navigator.of(ctx).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) return;

    final cubit = context.read<CreateTaskCubit>();
    final state = cubit.state;
    if (state is! CreateTaskReady || state.selectedMemberId == null) return;

    cubit.submitTask(
      projectId: widget.projectId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      deadline: '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
      gitLink: _gitLinkController.text.trim().isNotEmpty ? _gitLinkController.text.trim() : null,
    );
  }

  void _handleStateChange(BuildContext context, CreateTaskState state) {
    if (state is CreateTaskLoading) {
      LoadingDialog.show(context: context, message: 'Creating task...');
    } else if (state is CreateTaskSuccess) {
      LoadingDialog.hide(context);
      SuccessDialog.show(
        context: context,
        title: 'Task Created!',
        message: 'Task has been created successfully.',
        onAction: () => context.pop(),
      );
    } else if (state is CreateTaskError) {
      LoadingDialog.hide(context);
      ErrorDialog.show(
        context: context,
        title: AppStrings.error,
        message: state.message,
      );
    }
  }

  String _shortenName(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0]} ${parts[1][0]}.';
    }
    return name;
  }

  static const _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
}

class _MembersData {
  final List<TeamMemberEntity> members;
  final int? selectedId;

  const _MembersData(this.members, this.selectedId);
}
