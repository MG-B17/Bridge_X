import 'package:bridge_x/features/matching/domain/entities/ai_match_entity.dart';
import 'package:equatable/equatable.dart';

sealed class MatchingState extends Equatable {
  const MatchingState();

  @override
  List<Object?> get props => [];
}

class MatchingInitial extends MatchingState {
  const MatchingInitial();
}

class MatchingLoading extends MatchingState {
  const MatchingLoading();
}

class MatchingLoaded extends MatchingState {
  final AiMatchEntity data;

  const MatchingLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class MatchingError extends MatchingState {
  final String message;

  const MatchingError(this.message);

  @override
  List<Object?> get props => [message];
}
