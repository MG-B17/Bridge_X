import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/create_team/presentation/widgets/search_helper_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widget/layout/drag_handle.dart';

class AddMembersBottomSheet extends StatefulWidget {
  const AddMembersBottomSheet({super.key});

  @override
  State<AddMembersBottomSheet> createState() => _AddMembersBottomSheetState();
}

class _AddMembersBottomSheetState extends State<AddMembersBottomSheet> {
  late final ScrollCubit _scrollCubit;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _scrollCubit = context.read<ScrollCubit>();
    _searchController = TextEditingController();
    _scrollCubit.hide();
  }

  @override
  void dispose() {
    _scrollCubit.show();
    _searchController.dispose();
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
            color: colors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radius30),
            ),
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
                          AppStrings.addMembers,
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
                    AppStrings.expandYourCollaborationNetwork,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.spacing24),
                  BridgeXTextFormField(
                    fillColor: colors.divider.withValues(alpha: .3),
                    hint: AppStrings.searchTeamMembers,
                    controller: _searchController,
                    prefixIcon: Icons.search,
                    validator: AppValidator.required,
                    hintStyle: context.textTheme.bodySmall!.copyWith(
                      color: colors.textSecondary.withValues(alpha: .5),
                      fontSize: AppSpacing.fontSize14,
                    ),
                  ),
                  VerticalSpacing(AppSpacing.height32),
                  SearchHelperContent(),
                  //NoUserFoundedWidget(),
                  VerticalSpacing(AppSpacing.height32),
                  BridgeXButton(text: AppStrings.sendInvitation, onTap: () {}),
                  VerticalSpacing(AppSpacing.height20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
