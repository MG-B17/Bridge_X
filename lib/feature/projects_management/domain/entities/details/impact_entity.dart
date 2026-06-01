import 'package:equatable/equatable.dart';

class ImpactEntity extends Equatable {
  final String text;
  final String icon;

  const ImpactEntity({
    required this.text,
    required this.icon,
  });

  @override
  List<Object?> get props => [text, icon];
}
