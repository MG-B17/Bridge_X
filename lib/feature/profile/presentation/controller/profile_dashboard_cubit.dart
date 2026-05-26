import 'package:bridge_x/feature/profile/domain/usecases/get_profile_dashboard_usecase.dart';
import 'package:bridge_x/feature/profile/presentation/controller/profile_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDashboardCubit extends Cubit<ProfileDashboardState> {
  final GetProfileDashboardUseCase _getProfileDashboardUseCase;

  ProfileDashboardCubit({required GetProfileDashboardUseCase getProfileDashboardUseCase})
      : _getProfileDashboardUseCase = getProfileDashboardUseCase,
        super(ProfileDashboardInitial());

  Future<void> fetchProfileDashboard() async {
    if (state is ProfileDashboardLoading) return;

    emit(ProfileDashboardLoading());

    final result = await _getProfileDashboardUseCase();
    if (isClosed) return;

    result.fold(
      (failure) => emit(ProfileDashboardError(message: failure.message)),
      (dashboard) => emit(ProfileDashboardLoaded(dashboard: dashboard)),
    );
  }
}
