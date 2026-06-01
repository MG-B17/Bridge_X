import 'package:bridge_x/feature/projects_management/domain/entities/details/impact_entity.dart';

class ImpactModel {
  final String text;
  final String icon;

  const ImpactModel({
    required this.text,
    required this.icon,
  });

  factory ImpactModel.fromJson(Map<String, dynamic> json) {
    return ImpactModel(
      text: json['text'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }

  ImpactEntity toEntity() => ImpactEntity(text: text, icon: icon);
}
