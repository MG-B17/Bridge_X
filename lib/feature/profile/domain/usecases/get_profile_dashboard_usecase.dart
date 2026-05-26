import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/profile/domain/entities/profile_dashboard_entity.dart';
import 'package:bridge_x/feature/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileDashboardUseCase {
  final ProfileRepository repository;

  GetProfileDashboardUseCase({required this.repository});

  Future<Either<Failure, ProfileDashboardEntity>> call() {
    return repository.getProfileDashboard();
  }
}
