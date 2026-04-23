import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/h_space.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final int? badgeCount;
  final bool isDestructive;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileMenuItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
    this.badgeCount,
    this.isDestructive = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.spacing.md,
              horizontal: context.spacing.md,
            ),
            child: Row(
              children: [
                _MenuItemIcon(icon: icon, bgColor: iconBgColor, color: iconColor),
                HSpace(context.spacing.md),
                Expanded(
                  child: Text(
                    title,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isDestructive ? const Color(0xFFEF4444) : context.colors.textPrimary,
                    ),
                  ),
                ),
                if (badgeCount != null) _MenuItemBadge(count: badgeCount!),
                if (!isMeOrDestructive)
                  Icon(Icons.chevron_right_rounded, color: context.colors.textHint, size: 24.w),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: context.colors.divider,
            indent: context.spacing.md,
            endIndent: context.spacing.md,
          ),
      ],
    );
  }

  bool get isMeOrDestructive => isDestructive;
}

class _MenuItemIcon extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color color;
  const _MenuItemIcon({required this.icon, required this.bgColor, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.spacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: 20.w),
    );
  }
}

class _MenuItemBadge extends StatelessWidget {
  final int count;
  const _MenuItemBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.all(6.w),
      decoration: const BoxDecoration(color: Color(0xFFB91C1C), shape: BoxShape.circle),
      child: Text(
        count.toString(),
        style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
