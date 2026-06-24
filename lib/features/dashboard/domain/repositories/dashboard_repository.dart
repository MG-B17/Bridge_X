import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardEntity>> getRemoteDashboard({bool isRefresh = false});
  Future<Either<Failure, DashboardEntity>> getLocalDashboard();
}
