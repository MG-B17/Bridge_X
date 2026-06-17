import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/feature/create_team/domain/entity/programmer_search_entity.dart';
import 'package:bridge_x/feature/create_team/domain/repo/create_team_repo.dart';
import 'package:dartz/dartz.dart';

class SearchProgrammersUseCase {
  final CreateTeamRepo repository;

  SearchProgrammersUseCase({required this.repository});

  Future<Either<Failure, List<ProgrammerSearchEntity>>> call(String query) {
    return repository.searchProgrammers(query);
  }
}
