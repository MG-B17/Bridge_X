import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/profile/domain/entities/profile_dashboard_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileDashboardEntity>> getProfileDashboard();
}
