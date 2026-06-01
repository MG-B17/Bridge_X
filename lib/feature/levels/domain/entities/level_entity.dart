import 'package:equatable/equatable.dart';

class LevelEntity extends Equatable {
  final String currentLevelFull;
  final String baseLevel;
  final String subLevel;
  final int progressPercentage;
  final String nextLevelFull;
  final int totalTasks;
  final num averageRating;

  const LevelEntity({
    required this.currentLevelFull,
    required this.baseLevel,
    required this.subLevel,
    required this.progressPercentage,
    required this.nextLevelFull,
    required this.totalTasks,
    required this.averageRating,
  });

  @override
  List<Object?> get props => [
        currentLevelFull,
        baseLevel,
        subLevel,
        progressPercentage,
        nextLevelFull,
        totalTasks,
        averageRating,
      ];
}
