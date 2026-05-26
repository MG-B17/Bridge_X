import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/report/data/models/submit_report_request_model.dart';
import 'package:bridge_x/feature/report/domain/entities/report_entity.dart';
import 'package:bridge_x/feature/report/domain/repositories/report_repository.dart';
import 'package:dartz/dartz.dart';

class SubmitReportUseCase {
  final ReportRepository repository;

  SubmitReportUseCase({required this.repository});

  Future<Either<Failure, ReportEntity>> call(SubmitReportRequestModel request) {
    return repository.submitReport(request);
  }
}
