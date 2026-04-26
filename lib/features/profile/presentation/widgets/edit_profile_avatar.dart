import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class EditProfileAvatar extends StatelessWidget {
  final VoidCallback onTap;

  const EditProfileAvatar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundColor: context.colors.secondary,
                backgroundImage:
                    const NetworkImage('https://i.pravatar.cc/300?u=ahmed'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 14.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacing.sm),
          Text(
            AppStrings.tapToUpdateAvatar,
            style: context.labelSmall.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
