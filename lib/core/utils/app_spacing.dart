import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSpacing {
  //Spacing Scale 
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 16.w;
  static double get lg => 20.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;

  //Border Radius 
  static double get radiusXs => 8.r;
  static double get radiusCard => 12.r;
  static double get radiusCardLarge => 16.r;
  static double get radiusPill => 20.r;

  //Page / Component Padding
  static EdgeInsets get pagePadding =>
      EdgeInsets.symmetric(horizontal: md, vertical: md);

  static EdgeInsets get cardPadding =>
      EdgeInsets.symmetric(horizontal: md, vertical: sm);

  //Shadows 
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0x1F000000),
          blurRadius: 16.r,
          spreadRadius: 2.r,
          offset: Offset(0, 8.h),
        ),
      ];

  static List<BoxShadow> get subtleShadow => [
        BoxShadow(
          color: const Color(0x0F000000),
          blurRadius: 8.r,
          offset: Offset(0, 4.h),
        ),
      ];
}