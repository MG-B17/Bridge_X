import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/widget/scroller_listener.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/feature/chats/presentation/widgets/chat_list_widgets/chat_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/bridge_x_strings.dart';
import 'package:intl/intl.dart';
import '../../../../core/navigation/route_constant/bridege_x_route_names.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../../../core/widget/layout/vertical_spacing.dart';
import '../../../../core/widget/feedback/bridge_x_error_widget.dart';
import '../../../../core/widget/loading/bridge_x_refresh_indicator.dart';
import '../../../../core/widget/loading/bridge_x_skeletonizer.dart';
import '../../data/models/chat_model.dart';
import '../controller/chats_cubit.dart';
import '../controller/chats_state.dart';
import '../../domain/entities/chat_room_entity.dart';
import '../widgets/chat_list_widgets/chat_tile.dart';
import '../widgets/chat_list_widgets/empty_chat_view.dart';
import '../widgets/chat_list_widgets/recent_conversations_title.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ChatModel _mapEntityToModel(ChatRoomEntity entity) {
    return ChatModel(
      name: entity.teamName,
      message: entity.latestMessage != null
          ? "${entity.latestMessage!.user.fullName}: ${entity.latestMessage!.body}"
          : "No messages yet",
      time: entity.latestMessage != null
          ? DateFormat(
              'j',
            ).format(DateTime.parse(entity.latestMessage!.createdAt))
          : '',
      image: entity.avatarUrl ?? 'assets/images/team1.png', // Fallback image
      unreadCount: entity.unreadCount,
      isOnline: false, // Not provided by API
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNavListener(
      controller: _scrollController,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(AppSpacing.spacing24),
                Text(
                  AppStrings.chats,
                  style: AppTextStyles.displayLarge.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                VerticalSpacing(AppSpacing.spacing24),
                const ChatSearchBar(),
                VerticalSpacing(AppSpacing.spacing24),
                const RecentConversationsTitle(),
                VerticalSpacing(AppSpacing.spacing24),
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.only(bottom: AppSpacing.spacing20),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<ScrollCubit>().hide();
                          context.pushNamed(BridegeXRouteNames.chatDetails);
                        },
                        child: ChatTile(
                          chat: chats[index],
                          isSelected: index == 0,
                          onTap: () {
                            try {
                              context.read<ScrollCubit>().hide();
                              context.pushNamed(BridegeXRouteNames.chatDetails);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        VerticalSpacing(AppSpacing.spacing16),
                  ),
                ),
              ],
    return BlocProvider<ChatsCubit>(
      create: (context) => sl<ChatsCubit>()..getChats(),
      child: ScrollNavListener(
        controller: _scrollController,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
              child: BlocBuilder<ChatsCubit, ChatsState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalSpacing(AppSpacing.spacing24),
                      const ChatAppBar(),
                     
                      VerticalSpacing(AppSpacing.spacing24),
                      const RecentConversationsTitle(),
                      VerticalSpacing(AppSpacing.spacing24),
                      Expanded(child: _buildContent(context, state)),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ChatsState state) {
    if (state is ChatsError) {
      return BridgeXErrorWidget(
        errorTittle: "Something went wrong",
        errorMessage: state.message,
        refreshButtonTap: () => context.read<ChatsCubit>().getChats(),
      );
    }

    if (state is ChatsLoaded) {
      if (state.chats.isEmpty) {
        return const EmptyChatView();
      }

      final chatModels = state.chats.map((e) => _mapEntityToModel(e)).toList();

      return BridgeXRefreshIndicator(
        color: context.colors.primary,
        onRefresh: () async => context.read<ChatsCubit>().refreshChats(),
        child: ListView.separated(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: AppSpacing.spacing20),
          itemCount: chatModels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.read<ScrollCubit>().hide();
                context.pushNamed(BridegeXRouteNames.chatDetails);
              },
              child: ChatTile(
                chat: chatModels[index],
                onTap: () {
                  try {
                    context.read<ScrollCubit>().hide();
                    context.pushNamed(BridegeXRouteNames.chatDetails);
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
              ),
            );
          },
          separatorBuilder: (context, index) =>
              VerticalSpacing(AppSpacing.spacing16),
        ),
      );
    }

    // Default state (Initial or Loading)
    return BridgeXSkeletonizer(
      enableloading: true,
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: AppSpacing.spacing20),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ChatTile(
            chat: ChatModel(
              name: 'Team Loading',
              message: 'Loading message content...',
              time: '12:00 PM',
              image: 'assets/images/team1.png',
            ),
            isSelected: index == 0,
          );
        },
        separatorBuilder: (context, index) =>
            VerticalSpacing(AppSpacing.spacing16),
      ),
    );
  }
}
