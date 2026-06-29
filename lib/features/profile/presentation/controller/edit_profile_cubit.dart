import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/features/chat/domain/usecases/update_username_usecase.dart';
import 'package:bridge_x/features/profile/data/models/update_profile_request_model.dart';
import 'package:bridge_x/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:bridge_x/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:bridge_x/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bridge_x/features/profile/presentation/controller/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UpdateUsername _updateUsername;
 // final SecureStorageService _secureStorageService;
  EditProfileEntity? _cachedProfile;

  EditProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required UpdateUsername updateUsername,
    required SecureStorageService secureStorageService,
  }) : _getProfileUseCase = getProfileUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _updateUsername = updateUsername,
      // _secureStorageService = secureStorageService,
       super(EditProfileInitial());

  Future<void> fetchProfile() async {
    if (state is EditProfileLoading) return;

    emit(EditProfileLoading());

    final result = await _getProfileUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(EditProfileError(message: failure.message)),
      (profile) {
        _cachedProfile = profile;
        emit(EditProfileLoaded(profile: profile));
      },
    );
  }

  EditProfileEntity? _profileFromState(EditProfileState state) {
    if (state is EditProfileLoaded) return state.profile;
    if (state is EditProfileUpdating) return state.profile;
    if (state is EditProfileUpdated) return state.profile;
    return null;
  }

  Future<void> updateProfile(UpdateProfileRequestModel request) async {
    if (state is EditProfileUpdating) return;
    if (!request.hasChanges) return;

    final currentProfile = _cachedProfile ?? _profileFromState(state);
    if (currentProfile == null) return;

    emit(EditProfileUpdating(profile: currentProfile));

    final result = await _updateProfileUseCase(request);
    if (isClosed) return;

    result.fold(
      (failure) => emit(EditProfileError(message: failure.message)),
      (profile) async {
        _cachedProfile = profile;
        if (request.userName != null) {
          _updateUsername(UpdateUsernameParams(
            userId: profile.id,
            newUsername: request.userName!,
          ));
        }
      //  await _secureStorageService.write(key: AppKeys.userDataKey, value: profile.toJson());
        emit(EditProfileUpdated(profile: profile));
        fetchProfile();
      },
    );
  }
}
