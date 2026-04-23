import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/v_space.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIllustration(context),
        VSpace(context.spacing.xxl),
        Text(
          AppStrings.noMessages,
          style: context.displayLarge.copyWith(
            color: context.colors.textPrimary,
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        VSpace(context.spacing.md),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
          child: Text(
            AppStrings.noMessagesSubtitle,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIllustration(BuildContext context) {
    return SizedBox(
      height: 220.h,
      width: 220.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              color: context.colors.textHint.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Center(
              child: Icon(
                Icons.smart_toy,
                size: 60.w,
                color: context.colors.primary,
              ),
            ),
          ),
          Positioned(
            top: 20.h,
            right: 10.w,
            child: _buildBubble(context, Icons.chat_bubble_outline),
          ),
          Positioned(
            bottom: 20.h,
            left: 10.w,
            child: _buildBubble(context, Icons.chat_bubble_outline),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(BuildContext context, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [context.spacing.cardShadow],
      ),
      child: Icon(icon, color: context.colors.primary, size: 24.w),
    );
  }
}
