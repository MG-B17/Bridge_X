import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSpacing {
  static double get spacing2             => 2.w;
  static double get spacing4             => 4.w;
  static double get spacing6             => 6.w;
  static double get spacing8             => 8.w;
  static double get spacing10            => 10.w;
  static double get spacing12            => 12.w;
  static double get spacing14            => 14.w;
  static double get spacing16            => 16.w;
  static double get spacing18            => 18.w;
  static double get spacing20            => 20.w;
  static double get spacing24            => 24.w;
  static double get spacing30            => 30.w;
  static double get spacing32            => 32.w;

  static double get height2              => 2.h;
  static double get height3              => 3.h;
  static double get height4              => 4.h;
  static double get height6              => 6.h;
  static double get height8              => 8.h;
  static double get height10             => 10.h;
  static double get height14             => 14.h;
  static double get height16             => 16.h;
  static double get height18             => 18.h;
  static double get height40             => 40.h;

  static double get fontSize10           => 10.sp;
  static double get fontSize12           => 12.sp;
  static double get fontSize14           => 14.sp;
  static double get fontSize18           => 18.sp;
  static double get fontSize22           => 22.sp;
  static double get fontSize26           => 26.sp;

  static double get radius2              => 2.r;
  static double get radius6              => 6.r;
  static double get radius8              => 8.r;
  static double get radius10             => 10.r;
  static double get radius12             => 12.r;
  static double get radius16             => 16.r;
  static double get radius18             => 18.r;
  static double get radius20             => 20.r;
  static double get radius24             => 24.r;
  static double get radius28             => 28.r;
  static double get radius30             => 30.r;
  static double get radius32             => 32.r;

  static double get otpCellSize          => 45.w;
  static double get section              => 40.w;
  static double get logoWidth            => 135.w;
  static double get logoHeight           => 88.h;
  static double get headerTop            => 60.h;
  static double get onboardingImageHeight => 300.h;
  static double get iconBoxSize          => 44.w;
  static double get barColumnWidth       => 15.w;
  static double get barWidth             => 28.w;
  static double get barHeight            => 100.h;

  static const Duration animationNormal  = Duration(milliseconds: 300);
  static const Duration animationSlow    = Duration(milliseconds: 700);

  static EdgeInsets get pagePadding =>
      EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing16);

  static EdgeInsets get cardPadding =>
      EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing8);

  // Legacy aliases
  static double get xs            => spacing4;
  static double get sm            => spacing8;
  static double get md            => spacing16;
  static double get lg            => spacing20;
  static double get xl            => spacing24;
  static double get xxl           => spacing32;
  static double get width2        => spacing2;
  static double get width6        => spacing6;
  static double get width10       => spacing10;
  static double get width12       => spacing12;
  static double get width14       => spacing14;
  static double get width30       => spacing30;
  static double get radiusXs      => radius8;
  static double get radiusXxs     => radius6;
  static double get radiusLg      => radius24;
  static double get radiusXl      => radius32;
  static double get radiusCard    => radius12;
  static double get radiusCardLarge => radius16;
  static double get radiusPill    => radius20;
}
