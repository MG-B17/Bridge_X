import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_state.dart';
import 'package:bridge_x/feature/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:flutter/material.dart';

class RequestsCenterTabs extends StatelessWidget {
  final bool isLoading;
  final int invitationsCount;
  final int joinRequestsCount;
  final InvitaionsTab activeTab;
  final ValueChanged<InvitaionsTab> onTabChanged;

  const RequestsCenterTabs({
    super.key,
    required this.isLoading,
    required this.invitationsCount,
    required this.joinRequestsCount,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final invitationsTitle = '${InvitaionsStrings.invitationsTab} '
        '(${isLoading ? '...' : invitationsCount})';
    final joinRequestsTitle = '${InvitaionsStrings.joinRequestsTab} '
        '(${isLoading ? '...' : joinRequestsCount})';

    return Container(
      padding: EdgeInsets.all(AppSpacing.spacing4),
      decoration: BoxDecoration(
        color: context.appColors.primaryLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSpacing.radius12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _RequestsTabButton(
              title: invitationsTitle,
              isActive: activeTab == InvitaionsTab.invitations,
              onTap: () => onTabChanged(InvitaionsTab.invitations),
            ),
          ),
          Expanded(
            child: _RequestsTabButton(
              title: joinRequestsTitle,
              isActive: activeTab == InvitaionsTab.joinRequests,
              onTap: () => onTabChanged(InvitaionsTab.joinRequests),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestsTabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _RequestsTabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppSpacing.animationNormal,
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: AppSpacing.spacing12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radius10),
          gradient: isActive ? AppColorScheme.gradient : null,
          color: isActive ? null : Colors.transparent,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: isActive ? Colors.white : context.appColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
