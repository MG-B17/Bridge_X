import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditProfileActions extends StatelessWidget {
  const EditProfileActions({required this.onSave, super.key});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        BridgeXButton(text: AppStrings.saveChanges, onTap: onSave),

        VerticalSpacing(AppSpacing.md),

        
        GestureDetector(
          onTap: () {
            if (context.mounted) {
              context.pop();
            }
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: context.colors.divider, width: 1),
            ),
            child: Center(
              child: Text(
                AppStrings.cancel,
                style: AppTextStyles.titleMedium.copyWith(color: context.colors.textPrimary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
