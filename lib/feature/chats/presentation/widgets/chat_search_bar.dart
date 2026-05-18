import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/bridge_x_strings.dart';
import '../../../../core/theme/bridge_x_text_styles.dart';

class ChatSearchBar extends StatelessWidget {
  const ChatSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5FA),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE3E6EF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppStrings.searchTeamsOrMessages,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: const Color(0xFF9CA3AF),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Icon(
              Icons.search,
              size: 20.sp,
              color: const Color(0xFF7C8495),
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 20.w),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }
}
