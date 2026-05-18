import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/bridge_x_strings.dart';
import '../../../../core/theme/bridge_x_colors.dart';
import '../../../../core/theme/bridge_x_text_styles.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 58.h,
          maxHeight: 72.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.attach_file,
              size: 22.sp,
              color: AppColors.gray,
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: AppStrings.typeYourMessage,
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 15.sp,
                    color: AppColors.gray,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            InkWell(
              onTap: onSend,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.send,
                  color: AppColors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}