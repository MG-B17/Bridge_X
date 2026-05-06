import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HorizontalSpacing extends StatelessWidget {
  final double width;

  const HorizontalSpacing(this.width, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: width.w);
}
