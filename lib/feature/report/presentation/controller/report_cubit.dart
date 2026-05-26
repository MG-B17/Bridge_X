import 'package:bridge_x/feature/report/data/models/submit_report_request_model.dart';
import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';
import 'package:bridge_x/feature/report/domain/usecases/get_user_report_info_usecase.dart';
import 'package:bridge_x/feature/report/domain/usecases/submit_report_usecase.dart';
import 'package:bridge_x/feature/report/presentation/controller/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<ReportState> {
  final GetUserReportInfoUseCase _getUserReportInfoUseCase;
  final SubmitReportUseCase _submitReportUseCase;

  ReportCubit({
    required GetUserReportInfoUseCase getUserReportInfoUseCase,
    required SubmitReportUseCase submitReportUseCase,
  })  : _getUserReportInfoUseCase = getUserReportInfoUseCase,
        _submitReportUseCase = submitReportUseCase,
        super(ReportInitial());

  Future<void> fetchUserInfo(int userId) async {
    if (state is ReportUserInfoLoading) return;

    emit(ReportUserInfoLoading());

    final result = await _getUserReportInfoUseCase(userId);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ReportError(message: failure.message)),
      (userInfo) => emit(ReportUserInfoLoaded(userInfo: userInfo)),
    );
  }

  Future<void> submitReport({required int targetUserId, required String description}) async {
    if (state is ReportSubmitting) return;

    final currentUserInfo = _currentUserInfo;
    if (currentUserInfo == null) return;

    emit(ReportSubmitting(userInfo: currentUserInfo));

    final request = SubmitReportRequestModel(targetUserId: targetUserId, description: description);
    final result = await _submitReportUseCase(request);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ReportSubmitError(message: failure.message, userInfo: currentUserInfo)),
      (_) => emit(ReportSubmitted()),
    );
  }

  ReportedUserInfoEntity? get _currentUserInfo {
    final s = state;
    if (s is ReportUserInfoLoaded) return s.userInfo;
    if (s is ReportSubmitting) return s.userInfo;
    if (s is ReportSubmitError) return s.userInfo;
    return null;
  }
}
