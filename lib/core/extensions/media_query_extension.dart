import 'package:flutter/material.dart';

extension MediaQueryX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  double get safeAreaTop => MediaQuery.of(this).padding.top;

  double get safeAreaBottom => MediaQuery.of(this).padding.bottom;
}
