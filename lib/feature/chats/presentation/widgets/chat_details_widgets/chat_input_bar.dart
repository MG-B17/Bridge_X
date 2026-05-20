import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/horizontal_spacing.dart';
import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing10,
        vertical: AppSpacing.height20,
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: AppSpacing.height58,
          maxHeight: AppSpacing.height160,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing14,
          vertical: AppSpacing.height6,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: .18),
          borderRadius: BorderRadius.circular(AppSpacing.radius30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.height12),
              child: Icon(
                Icons.attach_file,
                size: AppSpacing.fontSize22,
                color: context.colors.textSecondary,
              ),
            ),
            HorizontalSpacing(AppSpacing.spacing12),
            Expanded(
              child: BridgeXTextFormField(
                controller: controller,
                hint: AppStrings.typeYourMessage,
                fillColor: context.colors.primary.withValues(alpha: .001),
                isDense: true,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.height12),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  fontSize: AppSpacing.fontSize15,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            InkWell(
              onTap: onSend,
              child: Container(
                width: AppSpacing.spacing48,
                height: AppSpacing.spacing48,
                decoration: BoxDecoration(
                  color: context.colors.secondary,
                  borderRadius: BorderRadius.circular(AppSpacing.radius16),
                ),
                child: Icon(
                  Icons.send,
                  color: AppColors.white,
                  size: AppSpacing.fontSize22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
