import 'package:flutter/material.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_search_bar.dart';
import '../widgets/chat_empty_state.dart';
import '../widgets/chat_list_item.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mocking the state for now. In a real app, this would come from a Bloc.
    bool hasMessages = DateTime.now().second % 2 == 0; 

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(context.spacing.md),
              const ChatHeader(),
              VSpace(context.spacing.xl),
              const ChatSearchBar(),
              VSpace(context.spacing.xl),
              if (!hasMessages)
                const Expanded(child: ChatEmptyState())
              else
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        AppStrings.recentConversations.toUpperCase(),
                        style: context.labelSmall.copyWith(
                          color: context.colors.textHint,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      VSpace(context.spacing.md),
                      ChatListItem(
                        title: 'Team Alpha',
                        lastMessage: "sarah: Let's finish the UI today, spe...",
                        time: '2:30 PM',
                        unreadCount: 2,
                        isOnline: true,
                        onTap: () => context.push('${AppRouteConstant.chat}/${AppRouteConstant.chatRoom}'), // Navigate to chat room
                      ),
                      ChatListItem(
                        title: 'Backend Core',
                        lastMessage: 'You: The API endpoints are now live...',
                        time: 'Yesterday',
                        onTap: () => context.push('${AppRouteConstant.chat}/${AppRouteConstant.chatRoom}'),
                      ),
                      ChatListItem(
                        title: 'DevOps Squad',
                        lastMessage: 'Ahmed: New deployment pipeline config...',
                        time: '10:15 AM',
                        onTap: () => context.push('${AppRouteConstant.chat}/${AppRouteConstant.chatRoom}'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
