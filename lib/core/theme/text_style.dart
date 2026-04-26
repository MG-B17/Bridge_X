import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get headlineSmall => GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      );
}
