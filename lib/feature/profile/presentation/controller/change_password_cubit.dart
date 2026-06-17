import 'package:bridge_x/feature/profile/data/models/change_password_request.dart';
import 'package:bridge_x/feature/profile/domain/usecases/change_password_usecase.dart';
import 'package:bridge_x/feature/profile/presentation/controller/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit({required ChangePasswordUseCase changePasswordUseCase})
      : _changePasswordUseCase = changePasswordUseCase,
        super(ChangePasswordInitial());

  Future<void> changePassword(ChangePasswordRequestModel request) async {
    if (state is ChangePasswordLoading) return;

    emit(ChangePasswordLoading());

    final result = await _changePasswordUseCase(request);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ChangePasswordError(message: failure.message)),
      (message) => emit(ChangePasswordSuccess(message: message)),
    );
  }
}
