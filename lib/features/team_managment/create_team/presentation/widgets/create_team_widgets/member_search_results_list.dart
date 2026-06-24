import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:bridge_x/features/team_managment/create_team/domain/entity/programmer_search_entity.dart';
import 'package:bridge_x/features/team_managment/create_team/presentation/widgets/create_team_widgets/member_search_result_item.dart';
import 'package:flutter/material.dart';

class MemberSearchResultsList extends StatelessWidget {
  const MemberSearchResultsList({
    super.key,
    required this.results,
    required this.colors,
    required this.scrollController,
    required this.isSelectedCallback,
    required this.onToggle,
  });

  final List<ProgrammerSearchEntity> results;
  final AppColorScheme colors;
  final ScrollController scrollController;
  final bool Function(ProgrammerSearchEntity) isSelectedCallback;
  final void Function(ProgrammerSearchEntity) onToggle;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final programmer = results[index];
        return MemberSearchResultItem(
          programmer: programmer,
          isSelected: isSelectedCallback(programmer),
          colors: colors,
          onTap: () => onToggle(programmer),
        );
      },
    );
  }
}
