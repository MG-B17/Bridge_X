import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/feature/chats/presentation/widgets/chat_list_widgets/chat_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyChatView extends StatelessWidget {
  const EmptyChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const ChatSearchBar(),

          SizedBox(height: 80.h),

          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 170.w,
                  height: 170.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 20.r,
                        offset: Offset(0, 8.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.smart_toy_outlined,
                            size: 52.sp,
                            color: context.colors.primary,
                          ),

                          Positioned(
                            top: -2.h,
                            right: -8.w,
                            child: Container(
                              width: 22.w,
                              height: 22.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF7B2CBF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: AppColors.white,
                                size: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _dot(),
                          SizedBox(width: 4.w),
                          _dot(active: true),
                          SizedBox(width: 4.w),
                          _dot(),
                        ],
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: -12.h,
                  right: -18.w,
                  child: _floatingBubble(),
                ),

                Positioned(
                  left: -22.w,
                  bottom: 18.h,
                  child: _floatingBubble(),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),

          Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF6A1B9A),
            ),
          ),

          SizedBox(height: 14.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.w),
            child: Text(
              'Start a conversation with your team to stay synced and collaborative. Real-time updates help everyone move faster.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: context.colors.textSecondary,
              ),
            ),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  static Widget _floatingBubble() {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Icon(
        Icons.chat_bubble_outline_rounded,
        size: 22.sp,
        color: const Color(0xFF4A6FA5),
      ),
    );
  }

  static Widget _dot({bool active = false}) {
    return Container(
      width: active ? 8.w : 6.w,
      height: active ? 8.w : 6.w,
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF8EC5FF)
            : const Color(0xFFD7E8FF),
        shape: BoxShape.circle,
      ),
    );
  }
}