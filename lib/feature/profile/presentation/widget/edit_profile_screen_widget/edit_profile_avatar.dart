import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({super.key});

  void _handleAvatarUpdate(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Avatar update coming soon')));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            // Avatar container
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.indigo.withValues(alpha: 0.15),
                border: Border.all(color: context.colors.indigo.withValues(alpha: 0.3), width: 2),
              ),
              child: Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/avatar.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: context.colors.indigo.withValues(alpha: 0.2),
                        child: Icon(Icons.person, size: 60.w, color: context.colors.indigo),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Camera icon button
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _handleAvatarUpdate(context),
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

        // Tap to update text
        Text(
          AppStrings.tapToUpdateAvatar,
          style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }
}
