import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bridge_x/feature/chats/domain/usecases/get_my_chats_usecase.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final GetMyChatsUseCase getMyChatsUseCase;

  ChatsCubit({required this.getMyChatsUseCase}) : super(ChatsInitial());

  Future<void> getChats() async {
    emit(ChatsLoading());
    final result = await getMyChatsUseCase.call();
    result.fold(
      (failure) => emit(ChatsError(failure.message)),
      (chats) => emit(ChatsLoaded(chats)),
    );
  }

  Future<void> refreshChats() async {
    // We can keep the previous state or show loading
    // Following common pattern: just call getChats
    await getChats();
  }
}
