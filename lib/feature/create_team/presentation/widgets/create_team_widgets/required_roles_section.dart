import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';

import 'package:bridge_x/core/widget/layout/bridge_x_chip.dart';

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
        VerticalSpacing(AppSpacing.spacing8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.spacing8),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radius12),
            border: Border.all(color: colors.divider, width: 1.2),
          ),
          child: Wrap(
            spacing: AppSpacing.spacing8,
            runSpacing: AppSpacing.height8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...widget.roles.map((role) => BridgeXChip(
                    label: role,
                    onRemove: () => widget.onRoleRemoved(role),
                    backgroundColor: colors.teal.withValues(alpha: 0.2),
                    borderColor: Colors.transparent,
                    selectedBorderColor: Colors.transparent,
                    textColor: colors.ongoingText,
                    borderRadius: AppSpacing.radius12,
                    textStyle: AppTextStyles.labelSmall,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacing10,
                      vertical: AppSpacing.height6,
                    ),
                  )),
              SizedBox(
                width: AppSpacing.width160,
                height: AppSpacing.height32,
                child: BridgeXTextFormField(
                  controller: _controller,
                  hint: AppStrings.addMoreHint,
                  fillColor: Colors.transparent,
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.spacing8,
                    vertical: AppSpacing.height6,
                  ),
                  hintStyle: AppTextStyles.labelSmall.copyWith(color: colors.textHint),
                  style: AppTextStyles.labelSmall.copyWith(color: colors.textPrimary),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submitRole(),
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(AppSpacing.height6),
        Text(
          AppStrings.rolesUsageDisclaimer,
          style: AppTextStyles.labelSmall.copyWith(
            color: colors.textSecondary,
            fontSize: AppSpacing.fontSize11,
          ),
        ),
      ],
    );
  }
}
