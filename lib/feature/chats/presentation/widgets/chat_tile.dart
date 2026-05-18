import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/chat_model.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final bool isSelected;
  final VoidCallback? onTap;

  const ChatTile({
    super.key,
    required this.chat,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightBlue, width: 1.w),
          color: isSelected ? const Color(0xFFEFF4FF) : AppColors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: NetworkImage(chat.image),
                    ),

                    if (chat.isOnline)
                      Positioned(
                        bottom: 0,
                        right: -1,
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),

                      SizedBox(height: 3.h),

                      Text(
                        chat.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10.w),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat.time,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    if (chat.unreadCount != null && chat.unreadCount! > 0)
                      Container(
                        width: 24.w,
                        height: 24.w,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${chat.unreadCount}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            if (!isSelected) ...[
              SizedBox(height: 10.h),
            ],
          ],
        ),
      ),
    );
  }
}
