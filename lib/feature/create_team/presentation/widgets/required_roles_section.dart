import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'role_chip.dart';

class RequiredRolesSection extends StatefulWidget {
  const RequiredRolesSection({
    super.key,
    required this.roles,
    required this.onRoleRemoved,
    required this.onRoleAdded,
  });

  final List<String> roles;
  final ValueChanged<String> onRoleRemoved;
  final ValueChanged<String> onRoleAdded;

  @override
  State<RequiredRolesSection> createState() => _RequiredRolesSectionState();
}

class _RequiredRolesSectionState extends State<RequiredRolesSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitRole() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onRoleAdded(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.requiredRoles,
          style: context.textTheme.labelMedium?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpacing(AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(color: colors.divider, width: 1.2),
          ),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...widget.roles.map((role) => RoleChip(
                    label: role,
                    onRemove: () => widget.onRoleRemoved(role),
                  )),
              SizedBox(
                width: 120.w,
                height: 32.h,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _submitRole(),
                  style: AppTextStyles.labelSmall.copyWith(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: AppStrings.addMoreHint,
                    hintStyle: AppTextStyles.labelSmall.copyWith(color: colors.textHint),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(6),
        Text(
          AppStrings.rolesUsageDisclaimer,
          style: AppTextStyles.labelSmall.copyWith(
            color: colors.textSecondary,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
