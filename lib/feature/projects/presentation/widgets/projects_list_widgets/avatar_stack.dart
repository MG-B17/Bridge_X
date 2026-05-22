import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/horizontal_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Horizontal overlapping avatar stack showing team member placeholders.
///
/// Displays up to [maxVisible] avatars, with a "+N" overflow indicator
/// when [totalCount] exceeds [maxVisible].
class AvatarStack extends StatelessWidget {
  const AvatarStack({
    super.key,
    required this.totalCount,
    this.maxVisible = 2,
    this.avatarSize = 32,
  });

  final int totalCount;
  final int maxVisible;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visibleCount = totalCount.clamp(0, maxVisible);
    final overflow = totalCount - maxVisible;

    // Placeholder colors for demo avatars
    const avatarColors = [
      Color(0xFF8B5CF6), // violet
      Color(0xFFF59E0B), // amber
      Color(0xFF06B6D4), // teal
    ];

    return SizedBox(
      height: avatarSize.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Overlapping avatars ──
          SizedBox(
            width: (avatarSize.w * 0.70) * visibleCount + avatarSize.w * 0.30,
            height: avatarSize.w,
            child: Stack(
              children: List.generate(visibleCount, (index) {
                return Positioned(
                  left: index * avatarSize.w * 0.60,
                  child: Container(
                    width: avatarSize.w,
                    height: avatarSize.w,
                    decoration: BoxDecoration(
                      color: avatarColors[index % avatarColors.length],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.surface,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: (avatarSize * 0.55).sp,
                    ),
                  ),
                );
              }),
            ),
          ),

          // ── Overflow badge ──
          if (overflow > 0) ...[
            HorizontalSpacing(AppSpacing.xs),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: colors.divider.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                '+$overflow',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
