import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import 'selection_pill_widget.dart';
import 'team_type_card_widget.dart';
import 'role_tag_widget.dart';

class TeamTypeSelector extends StatelessWidget {
  final bool isPrivate;
  final ValueChanged<bool> onChanged;

  const TeamTypeSelector({super.key, required this.isPrivate, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeamTypeCardWidget(
          title: AppStrings.privateTeam,
          description: AppStrings.privateTeamDesc,
          icon: Icons.lock_outline_rounded,
          isSelected: isPrivate,
          onTap: () => onChanged(true),
        ),
        TeamTypeCardWidget(
          title: AppStrings.publicTeam,
          description: AppStrings.publicTeamDesc,
          icon: Icons.public_rounded,
          isSelected: !isPrivate,
          onTap: () => onChanged(false),
        ),
      ],
    );
  }
}

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const CategorySelector({super.key, required this.selectedCategory, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      AppStrings.development,
      AppStrings.design,
      AppStrings.business,
      AppStrings.marketing,
    ];
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: categories
          .map((String cat) => SelectionPillWidget(
                label: cat,
                isSelected: selectedCategory == cat,
                onTap: () => onChanged(cat),
              ))
          .toList(),
    );
  }
}

class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        RoleTagWidget(label: 'Frontend Developer', onRemove: () {}),
        RoleTagWidget(label: 'UI/UX Designer', onRemove: () {}),
      ],
    );
  }
}
