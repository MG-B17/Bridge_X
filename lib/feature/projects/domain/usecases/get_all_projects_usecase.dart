import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects/domain/repo/all_projects_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllProjectsUseCase implements UseCase<AllProjectsEntity, NoParams> {
  final AllProjectsRepo repository;

  GetAllProjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, AllProjectsEntity>> call(NoParams params) async {
    return await repository.getAllProjects();
  }

  Future<Either<Failure, AllProjectsEntity>> loadMore(int page) async {
    return await repository.getAllProjects(page: page);
  }

  Future<Either<Failure, AllProjectsEntity>> loadCached() async {
    return await repository.getCachedProjects();
  }
}
