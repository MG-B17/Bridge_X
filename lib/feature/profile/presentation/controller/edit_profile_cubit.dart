import 'package:bridge_x/feature/profile/data/models/update_profile_request_model.dart';
import 'package:bridge_x/feature/profile/domain/entities/edit_profile_entity.dart';
import 'package:bridge_x/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:bridge_x/feature/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bridge_x/feature/profile/presentation/controller/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  EditProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        super(EditProfileInitial());

  Future<void> fetchProfile() async {
    if (state is EditProfileLoading) return;

    emit(EditProfileLoading());

    final result = await _getProfileUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(EditProfileError(message: failure.message)),
      (profile) => emit(EditProfileLoaded(profile: profile)),
    );
  }

  Future<void> updateProfile(UpdateProfileRequestModel request) async {
    if (state is EditProfileUpdating) return;
    if (!request.hasChanges) return;

    final currentProfile = _currentProfile;
    if (currentProfile == null) return;

    emit(EditProfileUpdating(profile: currentProfile));

    final result = await _updateProfileUseCase(request);
    if (isClosed) return;

    result.fold(
      (failure) => emit(EditProfileError(message: failure.message)),
      (profile) => emit(EditProfileUpdated(profile: profile)),
    );
  }

  EditProfileEntity? get _currentProfile {
    final s = state;
    if (s is EditProfileLoaded) return s.profile;
    if (s is EditProfileUpdating) return s.profile;
    if (s is EditProfileUpdated) return s.profile;
    return null;
  }
}
