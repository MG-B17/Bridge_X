import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleWidget extends StatelessWidget {
  const GoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/svgs/google_icon.svg",);
  }
}
