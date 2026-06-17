import 'package:flutter/material.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';

class ChatListEmptyState extends StatelessWidget {
  const ChatListEmptyState({super.key});

  static const _title = 'No messages yet';
  static const _subtitle =
      'Start a conversation with your team to stay synced and collaborative. Real-time updates help everyone move faster.';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        Center(
          child: SizedBox(
            width: AppSpacing.width220,
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140,
                  height: AppSpacing.height140,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(AppSpacing.radius32),
                  ),
                  child: const Center(
                    child: Icon(Icons.smart_toy_rounded, size: 64, color: Color(0xFF0F3E83)),
                  ),
                ),
                Positioned(
                  top: 36,
                  right: 36,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF6366F1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_rounded, size: 14, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 28,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.chat_bubble_outline_rounded, size: 20, color: Color(0xFF475569)),
                  ),
                ),
                Positioned(
                  top: 28,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.chat_rounded, size: 20, color: Color(0xFF0F3E83)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSpacing.height8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dot(AppSpacing.spacing8, AppSpacing.height8, const Color(0xFF93C5FD)),
            SizedBox(width: AppSpacing.spacing6),
            _dot(AppSpacing.spacing10, AppSpacing.height10, const Color(0xFF3B82F6)),
            SizedBox(width: AppSpacing.spacing6),
            _dot(AppSpacing.spacing8, AppSpacing.height8, const Color(0xFF93C5FD)),
          ],
        ),
        SizedBox(height: AppSpacing.height40),
        Text(
          _title,
          style: TextStyle(
            fontSize: AppSpacing.fontSize26,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4C1D95),
          ),
        ),
        SizedBox(height: AppSpacing.height12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing40),
          child: Text(
            _subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSpacing.fontSize15,
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  Widget _dot(double width, double height, Color color) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
