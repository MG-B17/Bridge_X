import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';

class ExperienceLevelSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ExperienceLevelSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const _levels = [
    AppStrings.beginner,
    AppStrings.junior,
    AppStrings.senior,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_outline_rounded,
                  size: 18.w, color: context.colors.textSecondary),
              HSpace(context.spacing.xs),
              Text(
                AppStrings.experienceLevel.toUpperCase(),
                style: context.labelSmall.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          VSpace(context.spacing.md),
          Row(
            children: List.generate(_levels.length, (i) {
              final isSelected = i == selectedIndex;
              return Padding(
                padding: EdgeInsets.only(right: context.spacing.sm),
                child: GestureDetector(
                  onTap: () => onChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.transparent
                          : context.colors.divider.withValues(alpha: 0.2),
                      borderRadius:
                          BorderRadius.circular(context.spacing.radiusPill),
                      border: Border.all(
                        color: isSelected
                            ? context.colors.primary
                            : context.colors.divider,
                        width: isSelected ? 2.w : 1.w,
                      ),
                    ),
                    child: Text(
                      _levels[i],
                      style: context.bodyMedium.copyWith(
                        color: isSelected
                            ? context.colors.primary
                            : context.colors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class SkillsEditor extends StatelessWidget {
  final List<String> skills;
  final VoidCallback onAddSkill;
  final ValueChanged<int> onRemoveSkill;

  const SkillsEditor({
    super.key,
    required this.skills,
    required this.onAddSkill,
    required this.onRemoveSkill,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.skills,
          style: context.bodyLarge.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        VSpace(context.spacing.sm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.spacing.md),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius:
                BorderRadius.circular(context.spacing.radiusCardLarge),
            border: Border.all(color: context.colors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: context.spacing.sm,
                runSpacing: context.spacing.sm,
                children: List.generate(skills.length, (i) {
                  return _SkillChip(
                    label: skills[i],
                    onRemove: () => onRemoveSkill(i),
                  );
                }),
              ),
              VSpace(context.spacing.sm),
              GestureDetector(
                onTap: onAddSkill,
                child: Text(
                  '+ ${AppStrings.addSkill}',
                  style: context.bodyMedium.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _SkillChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.colors.divider.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.bodyMedium.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 16.w,
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final String text;

  const ExperienceCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.work_outline_rounded,
                size: 18.w, color: context.colors.textPrimary),
            HSpace(context.spacing.xs),
            Text(
              AppStrings.experience,
              style: context.bodyLarge.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        VSpace(context.spacing.sm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.spacing.lg),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius:
                BorderRadius.circular(context.spacing.radiusCardLarge),
            border: Border.all(color: context.colors.divider),
          ),
          child: Text(
            text,
            style: context.bodyMedium.copyWith(
              color: context.colors.textPrimary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectItem extends StatelessWidget {
  final String name;
  final String role;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProjectItem({
    super.key,
    required this.name,
    required this.role,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spacing.sm),
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.bodyLarge.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  role,
                  style: context.labelSmall.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Icon(Icons.edit_outlined,
                size: 20.w, color: context.colors.textSecondary),
          ),
          HSpace(context.spacing.md),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.delete_outline_rounded,
                size: 20.w, color: context.colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class AddProjectForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController roleController;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const AddProjectForm({
    super.key,
    required this.nameController,
    required this.roleController,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.spacing.radiusCardLarge),
        border: Border.all(
          color: context.colors.primary,
          width: 1.5.w,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.projectName.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
          VSpace(context.spacing.xs),
          _buildField(context, AppStrings.projectNameHint, nameController),
          VSpace(context.spacing.md),
          Text(
            AppStrings.role.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
          VSpace(context.spacing.xs),
          _buildField(context, AppStrings.roleHint, roleController),
          VSpace(context.spacing.lg),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            context.spacing.radiusCard),
                      ),
                    ),
                    child: Text(
                      AppStrings.confirmAdd,
                      style: context.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              HSpace(context.spacing.md),
              GestureDetector(
                onTap: onCancel,
                child: Text(
                  AppStrings.cancel,
                  style: context.bodyMedium.copyWith(
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    BuildContext context,
    String hint,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      style: context.bodyMedium.copyWith(color: context.colors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.bodyMedium.copyWith(color: context.colors.textHint),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.spacing.md,
          vertical: context.spacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          borderSide: BorderSide(color: context.colors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          borderSide: BorderSide(color: context.colors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.spacing.radiusCard),
          borderSide: BorderSide(color: context.colors.primary),
        ),
      ),
    );
  }
}
