import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/bridge_x_strings.dart';
import '../../../../core/navigation/route_constant/bridege_x_route_names.dart';
import '../../../../core/theme/bridge_x_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../../../core/widget/vertical_spacing.dart';
import '../../data/mocks/chat_list.dart';
import '../widgets/chat_search_bar.dart';
import '../widgets/chat_tile.dart';
import '../widgets/recent_conversations_title.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(AppSpacing.spacing24),
              Text(
                AppStrings.chats,
                style: AppTextStyles.displayLarge.copyWith(color: context.colors.textPrimary),
              ),
              VerticalSpacing(AppSpacing.spacing24),
              const ChatSearchBar(),
              VerticalSpacing(AppSpacing.spacing24),
              const RecentConversationsTitle(),
              VerticalSpacing(AppSpacing.spacing24),
              Expanded(
                child: ListView.separated(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(BridegeXRouteNames.chatDetails);
                      },
                      child: ChatTile(
                        chat: chats[index],
                        isSelected: index == 0,
                        onTap: () {
                          try {
                            context.pushNamed(BridegeXRouteNames.chatDetails);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => VerticalSpacing(AppSpacing.spacing16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
