import 'package:bridge_x/feature/levels/domain/usecases/get_level_usecase.dart';
import 'package:bridge_x/feature/levels/presentation/controller/level_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelCubit extends Cubit<LevelState> {
  final GetLevelUseCase _getLevelUseCase;

  LevelCubit({required GetLevelUseCase getLevelUseCase})
      : _getLevelUseCase = getLevelUseCase,
        super(LevelInitial());

  Future<void> fetchLevel() async {
    if (state is LevelLoading) return;

    emit(LevelLoading());

    final result = await _getLevelUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(LevelError(message: failure.message)),
      (level) => emit(LevelLoaded(level: level)),
    );
  }
}
