import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/bridge_x_colors.dart';
import '../../../../core/theme/bridge_x_text_styles.dart';

class RecentConversationsTitle extends StatelessWidget {
  const RecentConversationsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.recentConversations,
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.gray,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}