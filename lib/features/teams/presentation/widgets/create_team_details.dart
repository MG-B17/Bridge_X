import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/bridge_dialogs.dart';
import '../../../../core/widgets/v_space.dart';

class CreateTeamHeader extends StatelessWidget {
  const CreateTeamHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.createTeam, style: context.displayLarge.copyWith(fontWeight: FontWeight.w900)),
        VSpace(context.spacing.sm),
        Text(AppStrings.createTeamSubtitle, style: context.bodyMedium.copyWith(color: context.colors.textSecondary)),
      ],
    );
  }
}

class CreateTeamForm extends StatelessWidget {
  const CreateTeamForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(context, AppStrings.teamName),
        VSpace(context.spacing.sm),
        const AppTextField(hintText: 'e.g. Project Phoenix'),
        VSpace(context.spacing.lg),
        _buildSectionLabel(context, AppStrings.githubUrl),
        VSpace(context.spacing.sm),
        const AppTextField(hintText: 'URL'),
        VSpace(context.spacing.lg),
        _buildSectionLabel(context, AppStrings.projectDescription),
        VSpace(context.spacing.sm),
        const AppTextField(hintText: AppStrings.describeProjectHint, maxLines: 4),
      ],
    );
  }

  Widget _buildSectionLabel(BuildContext context, String text) {
    return Text(text, style: context.bodyMedium.copyWith(fontWeight: FontWeight.w900, color: context.colors.textPrimary));
  }
}

class CreateTeamFooter extends StatelessWidget {
  const CreateTeamFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          label: AppStrings.addMember,
          isSecondary: true,
          onPressed: () {},
          leading: Icon(Icons.person_add_outlined, color: context.colors.primary, size: 20.w),
        ),
        VSpace(context.spacing.xxl),
        AppButton(
          label: AppStrings.createTeam,
          onPressed: () => BridgeDialogs.showTeamCreated(context),
          trailing: Icon(Icons.rocket_launch_outlined, color: Colors.white, size: 20.w),
        ),
        VSpace(context.spacing.xxl),
      ],
    );
  }
}
