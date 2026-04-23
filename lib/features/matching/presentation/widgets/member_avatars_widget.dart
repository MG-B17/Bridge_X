import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';

class MemberAvatarsWidget extends StatelessWidget {
  final int count;
  final String label;

  const MemberAvatarsWidget({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70.w,
          height: 32.w,
          child: Stack(
            children: [
              _buildAvatar(context, 0, Colors.amber),
              _buildAvatar(context, 1, Colors.blueGrey),
              _buildAvatar(context, 2, context.colors.primary, isLast: true),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, int index, Color color, {bool isLast = false}) {
    return Positioned(
      left: index * 18.w,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.w),
        ),
        child: isLast
            ? Center(
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const Icon(Icons.person, color: Colors.white, size: 16),
      ),
    );
  }
}
