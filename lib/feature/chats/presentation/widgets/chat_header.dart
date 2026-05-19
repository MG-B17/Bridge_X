import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/bridge_x_text_styles.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.teamAlpha,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.black,
                  ),
                ),
                Text(
                  AppStrings.membersOnline,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),

            const Spacer(),

            Icon(Icons.info_outline_rounded, color: AppColors.gray, size: 20),
          ],
        ),
      ),
    );
  }
}
