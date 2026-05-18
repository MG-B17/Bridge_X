import 'package:go_router/go_router.dart';

import '../../../feature/chats/presentation/screens/chat_details_screen.dart';
import '../../../feature/chats/presentation/screens/chat_list_screen.dart';

final chatRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatListScreen(),
      routes: [
        GoRoute(
          path: 'chat-details',
          builder: (context, state) => const ChatDetailsScreen(),
        ),
      ],
    ),
  ],
);