import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';
import 'package:bridge_x/feature/report/domain/repositories/report_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserReportInfoUseCase {
  final ReportRepository repository;

  GetUserReportInfoUseCase({required this.repository});

  Future<Either<Failure, ReportedUserInfoEntity>> call(int userId) {
    return repository.getUserReportInfo(userId);
  }
}
