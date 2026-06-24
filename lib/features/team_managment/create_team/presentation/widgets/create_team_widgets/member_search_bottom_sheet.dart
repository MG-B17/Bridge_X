import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_cubit.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/controller/create_team_state.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_agreement_text.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_invitation_button.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_search_empty_state.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_search_field.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_search_initial_state.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_search_results_list.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberSearchBottomSheet extends StatefulWidget {
  const MemberSearchBottomSheet({super.key});

  @override
  State<MemberSearchBottomSheet> createState() => _MemberSearchBottomSheetState();
}

class _MemberSearchBottomSheetState extends State<MemberSearchBottomSheet> {
  final _controller = TextEditingController();
  final _searchScrollController = ScrollController();
  CreateTeamCubit? _cubit;
  final Set<String> _selectedNames = {};

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreateTeamCubit>();
    _selectedNames.addAll(_cubit!.state.invitedMembers);
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _searchScrollController.dispose();
    _cubit?.clearSearchResults();
    super.dispose();
  }

  void _onSearchChanged() {
    _cubit?.searchProgrammers(_controller.text);
  }

  void _submitInvitations() {
    _cubit?.setInvitedMembers(_selectedNames.toList());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radius24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.spacing20,
            right: AppSpacing.spacing20,
            top: AppSpacing.spacing12,
            bottom: AppSpacing.spacing20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDragHandle(colors),
              VerticalSpacing(AppSpacing.spacing16),
              _buildHeader(colors),
              VerticalSpacing(AppSpacing.spacing20),
              MemberSearchField(controller: _controller, colors: colors),
              VerticalSpacing(AppSpacing.spacing16),
              Expanded(child: _buildBody(colors)),
              VerticalSpacing(AppSpacing.spacing16),
              MemberInvitationButton(
                colors: colors,
                isEnabled: _selectedNames.isNotEmpty,
                onPressed: _submitInvitations,
              ),
              _buildAgreementText(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle(AppColorScheme colors) {
    return Center(
      child: Container(
        width: AppSpacing.dragHandleWidth,
        height: AppSpacing.dragHandleHeight,
        decoration: BoxDecoration(
          color: colors.textSecondary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(2.5),
        ),
      ),
    );
  }

  Widget _buildHeader(AppColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                CreateTeamStrings.addTeamMembers,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              VerticalSpacing(AppSpacing.spacing4),
              Text(
                CreateTeamStrings.expandYourCollaborationNetwork,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colors.textSecondary,
                  fontSize: AppSpacing.fontSize13,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: colors.textPrimary,
            size: AppSpacing.fontSize24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildBody(AppColorScheme colors) {
    return BlocListener<CreateTeamCubit, CreateTeamState>(
      listenWhen: (previous, current) =>
          previous.searchResults != current.searchResults ||
          previous.searchLoading != current.searchLoading,
      listener: (context, state) {
        if (_searchScrollController.hasClients) {
          _searchScrollController.animateTo(
            0,
            duration: AppSpacing.animationFast,
            curve: Curves.easeOut,
          );
        }
      },
      child: BlocBuilder<CreateTeamCubit, CreateTeamState>(
        builder: (context, state) {
          final query = _controller.text.trim();

          if (query.isEmpty) {
            return MemberSearchInitialState(colors: colors);
          }

          if (state.searchLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: AppSpacing.strokeWidth3),
            );
          }

          if (state.searchError != null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing24),
                child: Text(
                  state.searchError!,
                  style: AppTextStyles.bodyMedium.copyWith(color: colors.error),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state.searchResults.isEmpty) {
            return MemberSearchEmptyState(colors: colors);
          }

          return MemberSearchResultsList(
            results: state.searchResults,
            colors: colors,
            scrollController: _searchScrollController,
            isSelectedCallback: (programmer) {
              final identifier = programmer.userName ?? programmer.fullName;
              return _selectedNames.contains(identifier);
            },
            onToggle: (programmer) {
              final identifier = programmer.userName ?? programmer.fullName;
              setState(() {
                if (_selectedNames.contains(identifier)) {
                  _selectedNames.remove(identifier);
                } else {
                  _selectedNames.add(identifier);
                }
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildAgreementText(AppColorScheme colors) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        if (value.text.trim().isNotEmpty) {
          return const SizedBox.shrink();
        }
        return MemberAgreementText(colors: colors);
      },
    );
  }
}
