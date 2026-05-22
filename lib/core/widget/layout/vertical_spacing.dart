import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpacing extends StatelessWidget {
  final double height;

  const VerticalSpacing(this.height, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: height.h);
}
