import 'package:bridge_x/core/error/failure.dart';
import 'package:bridge_x/core/usecase/usecases.dart';
import 'package:bridge_x/features/chat/domain/entities/chat_room_entity.dart';
import 'package:bridge_x/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchChatRooms implements UseCase<List<ChatRoomEntity>, SearchChatRoomsParams> {
  final ChatRepository repository;

  SearchChatRooms(this.repository);

  @override
  Future<Either<Failure, List<ChatRoomEntity>>> call(SearchChatRoomsParams params) async {
    return await repository.searchChatRooms(params.query);
  }
}

class SearchChatRoomsParams extends Equatable {
  final String query;

  const SearchChatRoomsParams({required this.query});

  @override
  List<Object?> get props => [query];
}