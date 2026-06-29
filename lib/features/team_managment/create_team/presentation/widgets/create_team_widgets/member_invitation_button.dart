import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/team_managment/utils/create_team_strings.dart';
import 'package:flutter/material.dart';

class MemberInvitationButton extends StatelessWidget {
  const MemberInvitationButton({
    super.key,
    required this.colors,
    required this.isEnabled,
    required this.onPressed,
  });

  final AppColorScheme colors;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.sendButtonHeight,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.textPrimary,
          disabledBackgroundColor: colors.divider.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radius16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              CreateTeamStrings.sendInvitation,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: AppSpacing.spacing8),
            Transform.rotate(
              angle: -0.25,
              child: Icon(
                Icons.send,
                size: AppSpacing.fontSize18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
