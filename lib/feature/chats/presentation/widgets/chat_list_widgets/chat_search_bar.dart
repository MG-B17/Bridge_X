import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:bridge_x/core/utils/app_shadow.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:flutter/material.dart';

class ChatSearchBar extends StatelessWidget {
  const ChatSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radius16),
        border: Border.all(color: context.colors.divider, width: 1),
        boxShadow: AppShadow.subtle,
      ),
      child: Center(
        child: BridgeXTextFormField(
          hint: AppStrings.searchTeamsOrMessages,
          fillColor: Colors.transparent,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.height10),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: context.colors.textHint),
          prefixIconWidget: Padding(
            padding: EdgeInsets.only(left: AppSpacing.spacing15, right: AppSpacing.spacing15),
            child: Icon(
              Icons.search,
              size: AppSpacing.fontSize20,
              color: context.colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
