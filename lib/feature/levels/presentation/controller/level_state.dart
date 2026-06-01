import 'package:bridge_x/feature/levels/domain/entities/level_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LevelState extends Equatable {
  const LevelState();

  @override
  List<Object?> get props => [];
}

class LevelInitial extends LevelState {}

class LevelLoading extends LevelState {}

class LevelLoaded extends LevelState {
  final LevelEntity level;

  const LevelLoaded({required this.level});

  @override
  List<Object?> get props => [level];
}

class LevelError extends LevelState {
  final String message;

  const LevelError({required this.message});

  @override
  List<Object?> get props => [message];
}
