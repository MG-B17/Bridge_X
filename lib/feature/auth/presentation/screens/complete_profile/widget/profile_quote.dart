import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileQuote extends StatelessWidget {
  const ProfileQuote({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            '"The secret of getting ahead is getting started. Your profile is the first step of your Bridge X legacy."',
            textAlign: TextAlign.center,
            style: text.bodySmall?.copyWith(
              color: colors.textSecondary.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
