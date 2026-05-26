import 'dart:io';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({
    super.key,
    this.avatarUrl,
    this.pickedImagePath,
    required this.onTap,
  });

  final String? avatarUrl;
  final String? pickedImagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.indigo.withValues(alpha: 0.15),
                border: Border.all(color: context.colors.indigo.withValues(alpha: 0.3), width: 2),
              ),
              child: Center(
                child: ClipOval(child: _buildImage(context)),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: context.colors.indigo,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.surface, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.indigo.withValues(alpha: 0.3),
                        blurRadius: 8.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18.w),
                ),
              ),
            ),
          ],
        ),
        VerticalSpacing(AppSpacing.md),
        Text(
          AppStrings.tapToUpdateAvatar,
          style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    if (pickedImagePath != null) {
      return Image.file(
        File(pickedImagePath!),
        width: 120.w,
        height: 120.w,
        fit: BoxFit.cover,
        errorBuilder: (_, e, _) => _fallback(context),
      );
    }
    if (avatarUrl != null) {
      return Image.network(
        avatarUrl!,
        width: 120.w,
        height: 120.w,
        fit: BoxFit.cover,
        errorBuilder: (_, e, _) => _fallback(context),
      );
    }
    return _fallback(context);
  }

  Widget _fallback(BuildContext context) {
    return Container(
      width: 120.w,
      height: 120.w,
      color: context.colors.indigo.withValues(alpha: 0.2),
      child: Icon(Icons.person, size: 60.w, color: context.colors.indigo),
    );
  }
}
