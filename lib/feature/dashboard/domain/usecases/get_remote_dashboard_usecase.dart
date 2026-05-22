import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/dashboard/domain/entities/dashboard_entity.dart';
import 'package:bridge_x/feature/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class GetRemoteDashboardUseCase {
  final DashboardRepository repository;

  GetRemoteDashboardUseCase({required this.repository});

  Future<Either<Failure, DashboardEntity>> call({bool isRefresh = false}) async {
    return await repository.getRemoteDashboard(isRefresh: isRefresh);
  }
}
