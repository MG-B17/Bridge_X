import 'package:bridge_x/core/theme/app_color_schema.dart';
import 'package:flutter/material.dart';


extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
  
  AppColorScheme get colors => Theme.of(this).extension<AppColorScheme>()!;
}
