import 'package:bridge_x/core/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarStack extends StatelessWidget {
  final List<String> avatarUrls;
  final int maxVisible;
  final double avatarSize;

  const AvatarStack({
    super.key,
    required this.avatarUrls,
    this.maxVisible = 5,
    this.avatarSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    final visibleAvatars = avatarUrls.take(maxVisible).toList();
    final extraCount = avatarUrls.length - visibleAvatars.length;
    final radius = (avatarSize / 2).r;
    final overlap = (avatarSize * 0.35).w;
    final totalVisible = visibleAvatars.length + (extraCount > 0 ? 1 : 0);
    final stackWidth = avatarSize.w + (totalVisible - 1) * (avatarSize.w - overlap);

    return SizedBox(
      width: stackWidth,
      height: avatarSize.h,
      child: Stack(
        children: [
          ...visibleAvatars.asMap().entries.map((entry) {
            final index = entry.key;
            final url = entry.value;
            return Positioned(
              left: index * (avatarSize.w - overlap),
              child: _buildAvatar(url, radius, context),
            );
          }),
          if (extraCount > 0)
            Positioned(
              left: visibleAvatars.length * (avatarSize.w - overlap),
              child: _buildExtraCount(extraCount, radius, context),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String url, double radius, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.appColors.surface, width: 1.5.w),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url),
        backgroundColor: context.appColors.primaryLight,
      ),
    );
  }

  Widget _buildExtraCount(int count, double radius, BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.appColors.primaryLight,
        border: Border.all(color: context.appColors.surface, width: 1.5.w),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: context.appColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
