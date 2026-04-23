import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';

class MemberAvatarWidget extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final bool isOnline;

  const MemberAvatarWidget({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.colors.divider),
              ),
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: context.colors.secondary,
                    child: Icon(Icons.person, color: context.colors.primary, size: 32.w),
                  ),
                ),
              ),
            ),
            if (isOnline) _buildOnlineIndicator(context),
          ],
        ),
        VSpace(context.spacing.xs),
        Text(
          name,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w900, color: context.colors.textPrimary),
        ),
        Text(
          role,
          style: context.labelSmall.copyWith(color: context.colors.textSecondary, fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget _buildOnlineIndicator(BuildContext context) {
    return Positioned(
      right: 4.w,
      bottom: 4.w,
      child: Container(
        width: 14.w,
        height: 14.w,
        decoration: BoxDecoration(
          color: const Color(0xFF10B981),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
