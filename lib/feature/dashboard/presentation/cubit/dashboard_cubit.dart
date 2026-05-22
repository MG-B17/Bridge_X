import 'package:bridge_x/feature/dashboard/domain/usecases/get_local_dashboard_usecase.dart';
import 'package:bridge_x/feature/dashboard/domain/usecases/get_remote_dashboard_usecase.dart';
import 'package:bridge_x/feature/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetRemoteDashboardUseCase getRemoteDashboardUseCase;
  final GetLocalDashboardUseCase getLocalDashboardUseCase;

  DashboardCubit({required this.getRemoteDashboardUseCase, required this.getLocalDashboardUseCase})
    : super(DashboardInitial());

  Future<void> loadDashboard({bool isRefresh = false}) async {
    if (state is DashboardLoading || state is DashboardRefreshing) return;

    if (isRefresh && state is DashboardLoaded) {
      emit(DashboardRefreshing(dashboard: (state as DashboardLoaded).dashboard));
    } else {
      emit(DashboardLoading());
    }

    final remoteResult = await getRemoteDashboardUseCase(isRefresh: isRefresh);
    if (isClosed) return;

    await remoteResult.fold(
      (failure) async {
        final localResult = await getLocalDashboardUseCase();
        if (isClosed) return;

        localResult.fold(
          (_) {
            emit(DashboardError(message: 'No internet connection'));
          },
          (cachedDashboard) {
            emit(
              DashboardLoaded(dashboard: cachedDashboard, errorMessage: 'No internet connection'),
            );
          },
        );
      },
      (freshDashboard) {
        emit(DashboardLoaded(dashboard: freshDashboard));
      },
    );
  }
}
