import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bridge_x/core/widget/layout/bridge_x_chip.dart';
import '../widgets/select_category_widgets/drag_handle.dart';
import '../widgets/select_category_widgets/multi_category_info_banner.dart';


class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  final Set<int> _selected = {0, 2};
  late final ScrollCubit _scrollCubit;

  static const _categories = [
    AppStrings.development,
    AppStrings.design,
    AppStrings.marketing,
    AppStrings.research,
    AppStrings.aiData,
    AppStrings.business,
  ];

  @override
  void initState() {
    super.initState();
    _scrollCubit = context.read<ScrollCubit>();
    _scrollCubit.hide();
  }

  @override
  void dispose() {
    _scrollCubit.show();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: colors.background,
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DragHandle(),
                  VerticalSpacing(AppSpacing.spacing24),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.selectCategory,
                          style: AppTextStyles.displayLarge.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(
                          Icons.close,
                          color: colors.textSecondary,
                          size: AppSpacing.fontSize22,
                        ),
                      ),
                    ],
                  ),
                  VerticalSpacing(AppSpacing.spacing4),
                  Text(
                    AppStrings.categorySheetSubtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.spacing24),
                  Wrap(
                    spacing: AppSpacing.spacing10,
                    runSpacing: AppSpacing.height12,
                    children: List.generate(_categories.length, (i) {
                      final isSelected = _selected.contains(i);
                      return BridgeXChip(
                        label: _categories[i],
                        isSelected: isSelected,
                        showCheckmark: true,
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
                        ? () => context.pushNamed(BridegeXRouteNames.matchingProcess)
                        : null,
                  ),
                  VerticalSpacing(AppSpacing.spacing16),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.pop(),
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
          ),
        ),
      ),
    );
  }
}
