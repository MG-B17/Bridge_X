import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_edit_button.dart';
import 'profile_avatar.dart';
import 'profile_info_section.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        const Align(
          alignment: Alignment.topLeft,
          child: ProfileEditButton(),
        ),

        
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(8.h), // Push down slightly
              const ProfileAvatar(),
              VerticalSpacing(AppSpacing.md),
              const ProfileInfoSection(),
            ],
          ),
        ),
      ],
    );
  }
}
