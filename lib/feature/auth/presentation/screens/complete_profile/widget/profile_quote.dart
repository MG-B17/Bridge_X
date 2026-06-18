import 'package:bridge_x/core/theme/bridge_x_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileQuote extends StatelessWidget {
  const ProfileQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Text(
        '"The secret of getting ahead is getting started. Your profile is the first step of your Bridge X legacy."',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: AppColors.gray,
          height: 1.6,
        ),
      ),
    );
  }
}
