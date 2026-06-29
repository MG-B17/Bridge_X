import 'package:flutter/material.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';

class ChatListSectionHeader extends StatelessWidget {
  final String title;

  const ChatListSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSpacing.spacing20, top: AppSpacing.height12, bottom: AppSpacing.height12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppSpacing.fontSize12,
          fontWeight: FontWeight.bold,
          color: context.colors.textHint,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
