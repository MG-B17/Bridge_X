import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class RequestsCenterLoadingList extends StatelessWidget {
  const RequestsCenterLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        2,
        (index) => Container(
          margin: EdgeInsets.only(bottom: AppSpacing.spacing16),
          height: AppSpacing.height160 + AppSpacing.height20,
          decoration: BoxDecoration(
            color: context.appColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radius16),
          ),
        ),
      ),
    );
  }
}
