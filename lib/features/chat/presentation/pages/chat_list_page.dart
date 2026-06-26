import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridge_x_route_paths.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/models/user_data_model.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_list_cubit.dart';
import 'package:bridge_x/features/chat/presentation/bloc/chat_list_state.dart';
import 'package:bridge_x/features/chat/presentation/widgets/chat_list_empty_state.dart';
import 'package:bridge_x/features/chat/presentation/widgets/chat_room_list_tile.dart';
import 'package:bridge_x/features/chat/presentation/widgets/search_bar_widget.dart' show SearchBarWidget;
import 'package:go_router/go_router.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late final ChatListCubit _cubit;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChatListCubit>();
    _initCubit();
  }

  Future<void> _initCubit() async {
    final secureStorage = sl<SecureStorageService>();
    final userDataStr = await secureStorage.read(key: AppKeys.userDataKey);
    if (userDataStr != null) {
      final userData = UserDataModel.userDecodedata(userEncodedData: userDataStr);
      _cubit.init(int.tryParse(userData.userId) ?? 0);
    }
    if (mounted) {
      setState(() => _initialized = true);
    }
  }

  void _onRoomTapped(String roomId, int userId) {
    _cubit.onChatRoomOpened(roomId);
    context.push('${BridgeXRoutePaths.chat}/${BridgeXRoutePaths.chatDetails}/$roomId', extra: userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: Column(
        children: [
          SearchBarWidget(onSearch: (query) => _cubit.searchChatRooms(query)),
          Expanded(
            child: _initialized
                ? BlocSelector<ChatListCubit, ChatListState, ChatListState>(
                    selector: (state) => state,
                    builder: (context, state) {
                      return _buildBody(state);
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ChatListState state) {
    switch (state) {
      case ChatListInitial():
        return const SizedBox.shrink();
      case ChatListLoading():
        return const Center(child: CircularProgressIndicator());
      case ChatListLoaded(rooms: final rooms):
        final secureStorage = sl<SecureStorageService>();
        return RefreshIndicator(
          onRefresh: () => _cubit.loadChatRooms(),
          child: ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              return ChatRoomListTile(
                chatRoom: rooms[index],
                onTapped: (roomId) {
                  secureStorage.read(key: AppKeys.userDataKey).then((data) {
                    if (data != null) {
                      final user = UserDataModel.userDecodedata(userEncodedData: data);
                      _onRoomTapped(roomId, int.tryParse(user.userId) ?? 0);
                    }
                  });
                },
              );
            },
          ),
        );
      case ChatListEmpty():
        return const ChatListEmptyState();
      case ChatListSearchEmpty():
        return const Center(child: Text('No rooms match your search'));
      case ChatListError(message: final message):
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message, style: TextStyle(color: context.colors.error)),
              SizedBox(height: AppSpacing.height16),
              ElevatedButton(
                onPressed: () => _cubit.loadChatRooms(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
