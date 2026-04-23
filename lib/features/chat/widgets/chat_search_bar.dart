import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constant/app_strings.dart';

class ChatSearchBar extends StatelessWidget {
  const ChatSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
      decoration: BoxDecoration(
        color: context.colors.textHint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
        border: Border.all(
          color: context.colors.textHint.withValues(alpha: 0.1),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppStrings.search,
          hintStyle: context.bodyMedium.copyWith(
            color: context.colors.textHint,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: context.colors.textHint,
            size: 20.w,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: context.spacing.sm),
        ),
      ),
    );
  }
}
