import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/v_space.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final String? selectedRole;
  final List<String> roles;
  final ValueChanged<String?> onRoleChanged;

  const EditProfileForm({
    super.key,
    required this.fullNameController,
    required this.usernameController,
    required this.emailController,
    required this.bioController,
    required this.selectedRole,
    required this.roles,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(context, AppStrings.fullName),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: fullNameController,
          hintText: AppStrings.fullName,
        ),
        VSpace(context.spacing.lg),
        _buildLabel(context, AppStrings.username),
        VSpace(context.spacing.sm),
        _buildUsernameField(context),
        VSpace(context.spacing.lg),
        _buildLabel(context, AppStrings.professionRole),
        VSpace(context.spacing.sm),
        _buildRoleDropdown(context),
        VSpace(context.spacing.lg),
        _buildLabel(context, AppStrings.email),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: emailController,
          hintText: AppStrings.companyEmailHint,
          keyboardType: TextInputType.emailAddress,
        ),
        VSpace(context.spacing.lg),
        _buildLabel(context, AppStrings.bio),
        VSpace(context.spacing.sm),
        AppTextField(
          controller: bioController,
          hintText: AppStrings.bio,
          maxLines: 4,
        ),
        VSpace(context.spacing.xs),
        Text(
          AppStrings.bioMaxCharsHint,
          style: context.labelSmall.copyWith(
            color: context.colors.textHint,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String label) {
    return Text(
      label,
      style: context.bodyMedium.copyWith(
        color: context.colors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return AppTextField(
      controller: usernameController,
      hintText: AppStrings.username,
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Text(
          AppStrings.available,
          style: context.labelSmall.copyWith(
            color: context.colors.success,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildRoleDropdown(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colors.textHint.withValues(alpha: 0.3),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.colors.textHint,
          ),
          style: context.bodyMedium.copyWith(
            color: context.colors.textPrimary,
          ),
          dropdownColor: context.colors.surface,
          items: roles.map((role) {
            return DropdownMenuItem<String>(
              value: role,
              child: Text(role),
            );
          }).toList(),
          onChanged: onRoleChanged,
        ),
      ),
    );
  }
}
