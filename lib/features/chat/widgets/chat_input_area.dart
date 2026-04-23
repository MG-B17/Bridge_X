import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/h_space.dart';

class ChatInputArea extends StatelessWidget {
  const ChatInputArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.md,
        vertical: context.spacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.spacing.radiusPill),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.attach_file, color: context.colors.textHint),
          HSpace(context.spacing.md),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.typeMessage,
                hintStyle: context.bodyMedium.copyWith(color: context.colors.textHint),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.send, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }
}
