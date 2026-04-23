import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatCodeBlock extends StatelessWidget {
  final String fileName;
  final String language;
  final String code;

  const ChatCodeBlock({
    super.key,
    required this.fileName,
    required this.language,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.sp,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fileName,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10.sp,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            language,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 10.sp,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
