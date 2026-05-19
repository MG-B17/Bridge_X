import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyChatView extends StatelessWidget {
  const EmptyChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 80.h),

            Container(
              width: 280.w,
              height: 280.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffF9F4FF),
                    Color(0xffF5FAFF),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.smart_toy,
                  size: 90.sp,
                  color: Color(0xff0A377F),
                ),
              ),
            ),

            SizedBox(height: 40.h),

            Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff6C2BB7),
              ),
            ),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                'Start a conversation with your team to stay synced and collaborative. Real-time updates help everyone move faster.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
