import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'category_chip.dart';
import 'category_sheet_header.dart';
import 'drag_handle.dart';
import 'multi_category_info_banner.dart';


Future<List<String>?> showSelectCategorySheet(BuildContext context) {
  return showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _SelectCategorySheet(),
  );
}

class _SelectCategorySheet extends StatefulWidget {
  const _SelectCategorySheet();

  @override
  State<_SelectCategorySheet> createState() => _SelectCategorySheetState();
}

class _SelectCategorySheetState extends State<_SelectCategorySheet> {
  final Set<int> _selected = {0, 2}; 

  static const _categories = [
    AppStrings.development,
    AppStrings.design,
    AppStrings.marketing,
    AppStrings.research,
    AppStrings.aiData,
    AppStrings.business,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radius30)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.spacing24,
        AppSpacing.height12,
        AppSpacing.spacing24,
        AppSpacing.spacing24,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragHandle(),
            VerticalSpacing(AppSpacing.spacing24),
            const CategorySheetHeader(),
            VerticalSpacing(AppSpacing.spacing24),
            Wrap(
              spacing: AppSpacing.spacing10,
              runSpacing: AppSpacing.height12,
              children: List.generate(_categories.length, (i) {
                final isSelected = _selected.contains(i);
                return CategoryChip(
                  label: _categories[i],
                  isSelected: isSelected,
                  onTap: () => setState(() {
                    isSelected ? _selected.remove(i) : _selected.add(i);
                  }),
                );
              }),
            ),
            VerticalSpacing(AppSpacing.spacing24),
            const MultiCategoryInfoBanner(),
            VerticalSpacing(AppSpacing.spacing24),
            BridgeXButton(
              text: AppStrings.startMatching,
              onTap: _selected.isNotEmpty
                  ? () => context.pushNamed(BridegeXRouteNames.matching)
                  : null,
            ),
            VerticalSpacing(AppSpacing.spacing16),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.height8),
                  child: Text(
                    AppStrings.cancel,
                    style: AppTextStyles.titleMedium.copyWith(color: colors.textPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
