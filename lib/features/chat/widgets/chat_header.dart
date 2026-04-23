import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constant/app_strings.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.chats,
      style: context.displayLarge.copyWith(
        color: context.colors.primary,
        fontSize: 28.sp,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
