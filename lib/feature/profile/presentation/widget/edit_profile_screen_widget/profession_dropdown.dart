import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfessionDropdown extends StatelessWidget {
  const ProfessionDropdown({
    required this.selectedValue,
    required this.professions,
    required this.onChanged,
    super.key,
  });

  final String selectedValue;
  final List<String> professions;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.professionRole,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpacing(6),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.divider, width: 1.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: selectedValue,
            items: professions
                .map((profession) => DropdownMenuItem(value: profession, child: Text(profession)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            style: context.textTheme.bodyMedium?.copyWith(color: context.colors.textPrimary),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              suffixIcon: Icon(Icons.expand_more, color: context.colors.textHint),
            ),
          ),
        ),
      ],
    );
  }
}
