import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/feature/projects_management/domain/entities/paginated_projects_entity.dart';
import 'package:bridge_x/feature/projects_management/domain/repositories/projects_management_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetProjectsUseCase
    implements UseCase<PaginatedProjectsEntity, GetProjectsParams> {
  final ProjectsManagementRepository repository;

  GetProjectsUseCase({required this.repository});

  @override
  Future<Either<Failure, PaginatedProjectsEntity>> call(
    GetProjectsParams params,
  ) async {
    return await repository.getProjects(
      page: params.page,
      status: params.status,
    );
  }
}

class GetProjectsParams extends Equatable {
  final int page;
  final String? status;

  const GetProjectsParams({this.page = 1, this.status});

  @override
  List<Object?> get props => [page, status];
}
