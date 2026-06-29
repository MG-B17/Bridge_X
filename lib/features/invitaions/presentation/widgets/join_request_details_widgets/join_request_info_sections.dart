import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/features/invitaions/presentation/utils/invitaions_strings.dart';
import 'package:bridge_x/features/invitaions/presentation/widgets/expertise_wrap.dart';
import 'package:flutter/material.dart';

class JoinRequestInfoSections extends StatelessWidget {
  final JoinRequestEntity joinRequest;

  const JoinRequestInfoSections({
    super.key,
    required this.joinRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          InvitaionsStrings.expertise,
          style: AppTextStyles.titleMedium.copyWith(
            color: context.appColors.textPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing10),
        ExpertiseWrap(tags: joinRequest.expertiseTags),
        VerticalSpacing(AppSpacing.spacing24),
        Text(
          InvitaionsStrings.about,
          style: AppTextStyles.titleMedium.copyWith(
            color: context.appColors.textPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        VerticalSpacing(AppSpacing.spacing8),
        Text(
          joinRequest.aboutText,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.appColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
