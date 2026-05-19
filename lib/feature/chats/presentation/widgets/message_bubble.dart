import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel messageModel;
  final Widget? customContent;

  const MessageBubble({
    super.key,
    required this.messageModel,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    if (messageModel.isMe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'You',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.gray,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 8.h),

          Container(
            constraints: BoxConstraints(
              maxWidth: 260.w,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28.r),
                topRight: Radius.circular(28.r),
                bottomLeft: Radius.circular(28.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Text(
              messageModel.message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white,
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            messageModel.time,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.gray,
              fontSize: 12.sp,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          messageModel.senderName,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.gray,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 10.h),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundImage: AssetImage(messageModel.avatar),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 260.w,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        topRight: Radius.circular(28.r),
                        bottomLeft: Radius.circular(28.r),
                        bottomRight: Radius.circular(28.r),
                      ),
                      border: Border.all(
                        color: AppColors.lightGray,
                      ),
                    ),
                    child: customContent ??
                        Text(
                          messageModel.message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.black,
                            height: 1.6,
                          ),
                        ),
                  ),

                  SizedBox(height: 8.h),

                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      messageModel.time,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.gray,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}