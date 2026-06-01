import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/report/data/models/submit_report_request_model.dart';
import 'package:bridge_x/feature/report/domain/entities/report_entity.dart';
import 'package:bridge_x/feature/report/domain/entities/reported_user_info_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ReportRepository {
  Future<Either<Failure, ReportedUserInfoEntity>> getUserReportInfo(int userId);
  Future<Either<Failure, ReportEntity>> submitReport(SubmitReportRequestModel request);
}
