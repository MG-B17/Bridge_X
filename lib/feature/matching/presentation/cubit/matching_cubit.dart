import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bridge_x/feature/matching/domain/usecases/get_ai_matches_usecase.dart';
import 'matching_state.dart';

class MatchingCubit extends Cubit<MatchingState> {
  final GetAiMatchesUseCase getAiMatchesUseCase;

  MatchingCubit({required this.getAiMatchesUseCase}) : super(const MatchingInitial());

  Future<void> fetchMatches() async {
    emit(const MatchingLoading());
    final result = await getAiMatchesUseCase(NoParams());
    result.fold(
      (failure) => emit(MatchingError(failure.message)),
      (data) => emit(MatchingLoaded(data)),
    );
  }

  Future<void> refreshMatches() async {
    await fetchMatches();
  }
}
