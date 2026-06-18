import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_outline_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/create_team/presentation/controller/create_team_cubit.dart';
import 'package:bridge_x/feature/create_team/presentation/controller/create_team_state.dart';
import 'package:bridge_x/feature/create_team/domain/entity/programmer_search_entity.dart';
import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';


class TeamMembersSection extends StatelessWidget {
  const TeamMembersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<CreateTeamCubit, CreateTeamState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.teamMembers,
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            VerticalSpacing(AppSpacing.spacing4),
            Text(
              AppStrings.inviteMembersManually,
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary,
              ),
            ),
            if (state.invitedMembers.isNotEmpty) ...[
              VerticalSpacing(AppSpacing.spacing8),
              Wrap(
                spacing: AppSpacing.spacing8,
                runSpacing: AppSpacing.spacing4,
                children: state.invitedMembers.map((username) {
                  return Chip(
                    label: Text(
                      username.startsWith('@') ? username : '@$username',
                      style: const TextStyle(fontSize: 13),
                    ),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => context
                        .read<CreateTeamCubit>()
                        .removeInvitedMember(username),
                  );
                }).toList(),
              ),
            ],
            VerticalSpacing(AppSpacing.spacing8),
            BridgeXOutlineButton(
              text: AppStrings.addMembers,
              prefixicon: Icons.group_add_outlined,
              onTap: () => _showAddMemberSheet(context),
            ),
          ],
        );
      },
    );
  }

  void _showAddMemberSheet(BuildContext context) {
    final cubit = context.read<CreateTeamCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _AddMemberSheetContent(),
      ),
    );
  }
}

class _AddMemberSheetContent extends StatefulWidget {
  const _AddMemberSheetContent();

  @override
  State<_AddMemberSheetContent> createState() => _AddMemberSheetContentState();
}

class _AddMemberSheetContentState extends State<_AddMemberSheetContent> {
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.82,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.spacing20,
            right: AppSpacing.spacing20,
            top: AppSpacing.spacing12,
            bottom: bottomInset > 0 ? bottomInset + AppSpacing.spacing10 : AppSpacing.spacing20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colors.textSecondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              VerticalSpacing(AppSpacing.spacing16),

              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Team Members',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        VerticalSpacing(AppSpacing.spacing4),
                        Text(
                          'Expand your collaboration network',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colors.textSecondary,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colors.textPrimary,
                      size: 24.sp,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              VerticalSpacing(AppSpacing.spacing20),

              // Search Text Field
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search by username',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: colors.textSecondary.withValues(alpha: 0.7),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colors.textSecondary.withValues(alpha: 0.8),
                    size: 20.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.divider.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.divider.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.primary,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  filled: true,
                  fillColor: colors.background.withValues(alpha: 0.4),
                ),
                textInputAction: TextInputAction.done,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              VerticalSpacing(AppSpacing.spacing16),

              // Dynamic Body
              Expanded(
                child: BlocBuilder<CreateTeamCubit, CreateTeamState>(
                  builder: (context, state) {
                    final query = _controller.text.trim();

                    if (query.isEmpty) {
                      return _buildInitialState(colors);
                    }

                    if (state.searchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 3),
                      );
                    }

                    if (state.searchError != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            state.searchError!,
                            style: AppTextStyles.bodyMedium.copyWith(color: colors.error),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    if (state.searchResults.isEmpty) {
                      return _buildEmptyState(colors);
                    }

                    return _buildSearchResultsList(results: state.searchResults, colors: colors);
                  },
                ),
              ),

              // Action Button Section
              VerticalSpacing(AppSpacing.spacing16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedNames.isNotEmpty ? _submitInvitations : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.textPrimary,
                    disabledBackgroundColor: colors.divider.withValues(alpha: 0.5),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Send Invitation',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Transform.rotate(
                        angle: -0.25,
                        child: Icon(
                          Icons.send,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Dynamic Agreement Link under the button (Only in initial state)
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _controller,
                builder: (context, value, _) {
                  if (value.text.trim().isNotEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      VerticalSpacing(AppSpacing.spacing12),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'By inviting members, you agree to our ',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: colors.textSecondary.withValues(alpha: 0.8),
                            ),
                            children: [
                              TextSpan(
                                text: 'Team Terms',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: colors.primary,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState(AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colors.primary.withValues(alpha: 0.15),
                  colors.primary.withValues(alpha: 0.0),
                ],
                radius: 0.8,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.people_alt_rounded,
                size: 64.sp,
                color: colors.primary.withValues(alpha: 0.85),
              ),
            ),
          ),
          VerticalSpacing(AppSpacing.spacing24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Find colleagues by their name\nor @username to start\ncollaborating.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: colors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.textSecondary.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Icon(
                Icons.people_outline_rounded,
                size: 40.sp,
                color: colors.textSecondary.withValues(alpha: 0.6),
              ),
            ),
          ),
          VerticalSpacing(AppSpacing.spacing20),
          Text(
            'No users found',
            style: AppTextStyles.titleLarge.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          VerticalSpacing(AppSpacing.spacing8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Text(
              'Try another username or email to invite them to the team.',
              style: AppTextStyles.labelSmall.copyWith(
                color: colors.textSecondary,
                fontSize: 13.sp,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildSearchResultsList({
    required List<ProgrammerSearchEntity> results,
    required AppColorScheme colors,
  }) {
    return ListView.builder(
      controller: _searchScrollController,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final programmer = results[index];
        final memberIdentifier = programmer.userName ?? programmer.fullName;
        final isSelected = _selectedNames.contains(memberIdentifier);
        final avatarUrl = programmer.avatarUrl?.trim();
        final hasAvatar = avatarUrl != null && avatarUrl.isNotEmpty;

        final usernameText = programmer.userName != null && programmer.userName!.isNotEmpty
            ? '@${programmer.userName}'
            : '';
        final trackText = programmer.track ?? '';
        final subtitleText = [
          if (usernameText.isNotEmpty) usernameText,
          if (trackText.isNotEmpty) trackText,
        ].join(' • ');

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? colors.primary.withValues(alpha: 0.04) : Colors.transparent,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedNames.remove(memberIdentifier);
                } else {
                  _selectedNames.add(memberIdentifier);
                }
              });
            },
            leading: CircleAvatar(
              radius: 22.r,
              backgroundColor: colors.primaryLight.withValues(alpha: 0.5),
              backgroundImage: hasAvatar ? CachedNetworkImageProvider(avatarUrl) : null,
              child: hasAvatar
                  ? null
                  : Text(
                      programmer.fullName.isNotEmpty ? programmer.fullName[0].toUpperCase() : '?',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            title: Text(
              programmer.fullName,
              style: AppTextStyles.bodyMedium.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: subtitleText.isNotEmpty
                ? Text(
                    subtitleText,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colors.textSecondary,
                    ),
                  )
                : null,
            trailing: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? colors.textPrimary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? colors.textPrimary : colors.textSecondary.withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: colors.surface,
                      size: 14,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
