import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/auth/utils/auth_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileQuote extends StatelessWidget {
  const ProfileQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing12),
      child: Text(
        AuthStrings.quoteText,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: AppSpacing.fontSize14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: context.colors.textSecondary,
          height: 1.6,
        ),
      ),
    );
  }
}
