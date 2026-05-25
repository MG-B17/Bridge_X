import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/all_projects_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllProjectsUseCase implements UseCase<AllProjectsEntity, GetAllProjectsParams> {
  final ProjectsManagementRepository repository;

  GetAllProjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, AllProjectsEntity>> call(GetAllProjectsParams params) async {
    return await repository.getAllProjects(page: params.page);
  }
}

class GetAllProjectsParams extends Equatable {
  final int page;

  const GetAllProjectsParams({this.page = 1});

  @override
  List<Object?> get props => [page];
}
