import 'package:bridge_x/features/skills_and_experience/data/model/update_skills_experience_request_model.dart';
import 'package:bridge_x/features/skills_and_experience/domain/entities/skills_experience_entity.dart';
import 'package:bridge_x/features/skills_and_experience/domain/usecases/get_skills_experience_usecase.dart';
import 'package:bridge_x/features/skills_and_experience/domain/usecases/update_skills_experience_usecase.dart';
import 'package:bridge_x/features/skills_and_experience/presentation/controller/skills_experience_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsExperienceCubit extends Cubit<SkillsExperienceState> {
  final GetSkillsExperienceUseCase _getSkillsExperienceUseCase;
  final UpdateSkillsExperienceUseCase _updateSkillsExperienceUseCase;

  SkillsExperienceEntity? _cachedSkillsExperience;

  SkillsExperienceCubit({
    required GetSkillsExperienceUseCase getSkillsExperienceUseCase,
    required UpdateSkillsExperienceUseCase updateSkillsExperienceUseCase,
  }) : _getSkillsExperienceUseCase = getSkillsExperienceUseCase,
       _updateSkillsExperienceUseCase = updateSkillsExperienceUseCase,
       super(SkillsExperienceInitial());

  Future<void> fetchSkillsExperience() async {
    if (state is SkillsExperienceLoading) return;

    emit(SkillsExperienceLoading());

    final result = await _getSkillsExperienceUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(SkillsExperienceError(message: failure.message)),
      (skillsExperience) {
        _cachedSkillsExperience = skillsExperience;
        emit(SkillsExperienceLoaded(skillsExperience: skillsExperience));
      },
    );
  }

  SkillsExperienceEntity? _skillsExperienceFromState(
    SkillsExperienceState state,
  ) {
    if (state is SkillsExperienceLoaded) return state.skillsExperience;
    if (state is SkillsExperienceUpdating) return state.skillsExperience;
    if (state is SkillsExperienceUpdated) return state.skillsExperience;
    return null;
  }

  Future<void> updateSkillsExperience(
    UpdateSkillsExperienceRequestModel request,
  ) async {
    if (state is SkillsExperienceUpdating) return;

    final currentSkillsExperience =
        _cachedSkillsExperience ?? _skillsExperienceFromState(state);
    if (currentSkillsExperience == null) return;

    emit(SkillsExperienceUpdating(skillsExperience: currentSkillsExperience));

    final result = await _updateSkillsExperienceUseCase(request);
    if (isClosed) return;

    result.fold(
      (failure) => emit(SkillsExperienceError(message: failure.message)),
      (_) {
        emit(SkillsExperienceUpdated(skillsExperience: currentSkillsExperience));
        fetchSkillsExperience();
      },
    );
  }
}
